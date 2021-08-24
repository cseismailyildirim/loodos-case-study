//
//  SearchResponseModel.swift
//  LoodosCaseStudy
//
//  Created by ismailyildirim on 21.08.2021.
//

import Foundation

struct SearchResponseModel: Codable {
    var Search: [SearchItemModel]?
    var totalResults: String?
    var Response: String?
}

struct SearchItemModel: Codable {
    var Title: String?
    var Year: String?
    var imdbID: String?
    var type: String?
    var Poster: String?
}
