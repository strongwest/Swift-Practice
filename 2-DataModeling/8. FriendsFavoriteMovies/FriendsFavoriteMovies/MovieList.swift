import SwiftUI
import SwiftData

struct MovieList: View {
    @Query private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?
    
    init(titleFilter: String = ""){
        // 쿼리를 직접 생성하는 초기화자 선언
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
            // || : or, localizedStandardContains: 대소문자 무시, 악센트 문자(스페인)까지 처리
            // 필터가 비어이있거나, titleFilter의 텍스트가 포함되어 있는 경우 영화를 포함해라
        }
        
        _movies = Query(filter: predicate, sort: \Movie.title)
        //언더바 왜 쓰지
    }
    
    var body: some View {
        Group{
            if !movies.isEmpty {
                List {
                    ForEach(movies) { movie in
                        NavigationLink(movie.title) {
                            MovieDetail(movie: movie)
                        }
                    }
                    .onDelete(perform: deleteMovies(indexes:))
                }
            } else {
                ContentUnavailableView("Add Movies", systemImage: "film.stack")
            }
        }
        .navigationTitle("Movies")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem {
                Button("Add movie", systemImage: "plus", action: addMovie)
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $newMovie) { movie in
            NavigationStack {
                MovieDetail(movie: movie, isNew: true)
            }
            .interactiveDismissDisabled()
        }
        //detail: {
        //            Text("Select a movie")
        //                .navigationTitle("Movie")
        //        }
    }
    
    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }
    
    private func deleteMovies(indexes: IndexSet) {
        for index in indexes {
            context.delete(movies[index])
        }
    }
}

#Preview {
    NavigationStack{
        MovieList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty List") {
    NavigationStack{
        MovieList()
            .modelContainer(for: Movie.self, inMemory: true)
    }
}
