//
//  Attraction.swift
//  Guidebook
//
//  Created by Bern N on 10/12/23.
//

import Foundation

struct Attraction: Identifiable {
    var id = UUID()
    var name: String
    var summary: String
    var longDescription: String
    var imageName: String
    var latLong: String
}
