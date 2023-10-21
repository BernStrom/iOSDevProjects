//
//  Business.swift
//  Citysights
//
//  Created by Bern N on 10/21/23.
//

import Foundation

struct Business: Decodable, Identifiable {
    var id: String?
    var alias: String?
    var categories: [Category]
    var coordinates: Coordinate?
    var displayPhone: String?
    var distance: Double?
    var imageUrl: String?
    var isClosed: Bool
    var location: Location?
    var name: String?
    var phone: String?
    var price: String?
    var rating: Double?
    var reviewCount: Int?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case displayPhone = "display_phone"
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        
        case id, alias, categories, coordinates, distance, location, name, phone, price, rating, url
    }
}

struct Category: Decodable {
    var alias: String?
    var title: String?
}

struct Location: Decodable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var country: String?
    var displayAddress: [String]?
    var state: String?
    var zipCode: String?
    
    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
        case zipCode = "zip_code"
        
        case address1, address2, address3, city, country, state
    }
}
