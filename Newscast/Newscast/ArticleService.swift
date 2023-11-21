//
//  ArticleService.swift
//  Newscast
//
//  Created by Bern N on 11/21/23.
//

import Foundation

struct ArticleService: Decodable {
    var totalResults: Int?
    var articles: [Article]?
}
