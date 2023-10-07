//
//  ContentView.swift
//  Movie
//
//  Created by Bern N on 10/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var movieItems: [MovieItem] = [MovieItem]()
    @State private var watchedStatus = false
    var dataService = DataService()
    
    var body: some View {
        NavigationView {
            VStack {
                List(movieItems) { movie in
                    MovieListRow(movie: movie)
                }
                .navigationTitle(watchedStatus ? "Watched" : "List to Watch")
                .onAppear {
                    movieItems = dataService.getListToWatch()
                }
                
                HStack {
                    ListButton(title: "List to Watch", borderColor: .blue) {
                        movieItems = dataService.getListToWatch()
                        watchedStatus = false
                    }
                    
                    ListButton(title: "Watched", borderColor: .blue) {
                        movieItems = dataService.getWatchedList()
                        watchedStatus = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
