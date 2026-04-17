//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by 강서현 on 4/17/26.
//

import SwiftUI
import SwiftData

struct FilteredMovieList: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationSplitView{
            MovieList(titleFilter: searchText)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        } detail: {
            Text("Select a Movie")
        }
    }
}

#Preview {
    FilteredMovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
