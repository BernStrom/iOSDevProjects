//
//  MovieListRow.swift
//  Movie
//
//  Created by Bern N on 10/7/23.
//

import SwiftUI

struct MovieListRow: View {
    var movie: MovieItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(movie.title)
                    .font(.title3)
                Spacer()
                Text(movie.yearOfRelease)
            }
            .bold()
            
            Text("Directed by: \(movie.directorName)")
            Spacer()
            Text(movie.description)
            Spacer()
            
            HStack {
                Text("Personal Rating:")
                ForEach(1...movie.rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }
        }
        .padding()
    }
}

#Preview {
    MovieListRow(movie: MovieItem(title: "The Godfather", description: "A crime drama that explores the Italian-American Mafia, featuring Marlon Brando and Al Pacino.", directorName: "Francis Ford Coppola", yearOfRelease: "1972", watched: true, rating: 5))
}
