//
//  MovieList.swift
//  FriendsFavoriteMovies
//
//  Created by 강서현 on 4/12/26.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?
    
    var body: some View {
        NavigationSplitView{
            List {
                ForEach(movies) { movie in
                    NavigationLink(movie.title) {
                        MovieDetail(movie: movie, isNew: true)
                    }
//                    .navigationTitle("Movie")
//                    .navigationBarTitleDisplayMode(.inline)
                }
                .onDelete(perform: deleteMovies(indexes:))
                // 스와이프 해서 삭제
            }
            .navigationTitle("Movies")
            .toolbar {
                ToolbarItem{
                    Button("Add movie", systemImage: "plus", action: addMovie)
                }
                ToolbarItem(placement: .topBarTrailing){
                    EditButton()
                    // 오 이거 좋다
                }
            }
            .sheet(item: $newMovie) { movie in
                NavigationStack{
                    MovieDetail(movie: movie, isNew: true)
                }
                .interactiveDismissDisabled()
            }
            
        } detail : {
            Text("Select a movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }
    
    private func deleteMovies(indexes: IndexSet){
        for index in indexes {
            context.delete(movies[index])
        }
    }
    
}

#Preview {
    MovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
