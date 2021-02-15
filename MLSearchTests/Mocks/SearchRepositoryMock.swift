//
//  SearchRepositoryMock.swift
//  MLSearchTests
//
//  Created by Vitor Ferraz Varela on 14/02/21.
//

import Foundation
@testable import MLSearch

class SearchRepositoryMock: SearchRepository {
    var didCallFetchProducts = false
    var result: (Result<SearchResponse, Error>)!
    func fetchProducts(by text: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        didCallFetchProducts = true
        completion(result)
    }
}
