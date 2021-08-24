//
//  ServiceConfig.swift
//  BaseProject
//
//  Created by ismailyildirim on 21.08.2021.
//

import Foundation
import Alamofire

enum RequestType {
    
    var baseURL: String {
        return "http://www.omdbapi.com/?apikey=49454fee"
    }
    
    case search(String)
    case detail(String)
    
    var endpoint: String {
        switch self {
        case .search:
            return "\(baseURL)"
        case .detail(_):
            return "\(baseURL)"
        }
    }
    
    var request: [String: Any]? {
        switch self {
        case .search(let searchText):
            return ["s": searchText]
        case .detail(let  imdbId):
            return ["i": imdbId]
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .search:
            return .get
        case .detail(_):
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
