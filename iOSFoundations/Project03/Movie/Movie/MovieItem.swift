//
//  MovieItem.swift
//  Movie
//
//  Created by Bern N on 10/7/23.
//

import Foundation

struct MovieItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var directorName: String
    var yearOfRelease: String
    var watched: Bool
    var rating: Int
}
