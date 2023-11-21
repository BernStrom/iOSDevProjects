//
//  Article.swift
//  Newscast
//
//  Created by Bern N on 11/21/23.
//

import Foundation

struct Article: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
}
