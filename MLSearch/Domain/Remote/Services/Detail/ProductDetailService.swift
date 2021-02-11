//
//  ProductDetailService.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation
import RequestNetwork

enum ProductDetailService: Service {
    
    case productId(text: String)
    
    var path: String {
        "items"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .productId(let id):
            return [URLQueryItem(name: "ids", value: id)]
        }
    }
}
