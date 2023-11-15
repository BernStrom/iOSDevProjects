//
//  MenuItem.swift
//  Restaurant
//
//  Created by Bern N on 10/9/23.
//

import Foundation

struct MenuItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var price: String
    var imageName: String
}
