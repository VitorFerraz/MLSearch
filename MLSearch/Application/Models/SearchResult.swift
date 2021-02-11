//
//  SearchResult.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation

struct SearchResult: Codable, Hashable {
    let id: String
    let price: Double?
    let thumbnail: String
    let title: String
}
