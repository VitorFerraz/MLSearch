//
//  SearchService.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation
import RequestNetwork

enum SearchRequest: Service {
    case searchBy(text: String)
    
    var path: String {
        "sites/MLB/search"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .searchBy(let text):
            return [URLQueryItem(name: "q", value: text)]
        }
    }
}
