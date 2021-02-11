//
//  SearchRepository.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation
protocol SearchRepository {
    func fetchProducts(by text: String, completion: @escaping (Result<SearchResponse, Error>) -> Void)
}
