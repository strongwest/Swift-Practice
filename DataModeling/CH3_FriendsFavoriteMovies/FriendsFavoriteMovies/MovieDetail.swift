//
//  MovieDetail.swift
//  FriendsFavoriteMovies
//
//  Created by 강서현 on 4/12/26.
//

import SwiftUI
import SwiftData

struct MovieDetail: View {
    @Bindable var movie: Movie
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Form {
            TextField("Movie title", text: $movie.title)
            
            DatePicker("Release date", selection: $movie.releaseDate, displayedComponents: .date)
        }
        .navigationTitle(isNew ? "New Movie" : "Movie")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            if isNew {
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        context.delete(movie)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview("New Movie"){
    NavigationStack{
        MovieDetail(movie: SampleData.shared.movie, isNew: true)
    }
}
