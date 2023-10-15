//
//  City.swift
//  Guidebook
//
//  Created by Bern N on 10/12/23.
//

import Foundation

struct City: Identifiable, Decodable {
    let id = UUID()
    var name: String
    var summary: String
    var imageName: String
    var attractions: [Attraction]
}
