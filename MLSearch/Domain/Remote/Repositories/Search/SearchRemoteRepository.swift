//
//  SearchRemoteRepository.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation
import RequestNetwork

final class SearchRemoteRepository: SearchRepository {
    private let network = NetworkManager<SearchService>()

    func fetchProducts(by text: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        network.request(service: .searchBy(text: text), result: completion)
    }
}
