//
//  SearchResult.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation

struct SearchResult: Codable {
    let id: String
    let price: Double?
    let shipping: Bool
    let thumbnail: String
    let title: String
}
