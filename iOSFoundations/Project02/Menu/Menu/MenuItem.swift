//
//  MenuItem.swift
//  Menu
//
//  Created by Bern N on 10/7/23.
//

import Foundation

struct MenuItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var price: String
    var imageName: String
}
