//
//  DetailRemoteRepository.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation
import RequestNetwork

final class DetailRemoteRepository: DetailRepository {
    private let network = NetworkManager<ProductDetailService>()

    func fetchDetail(productId: String, completion: @escaping (Result<[ProductDetailResponse], Error>) -> Void) {
        network.request(service: .productId(text: productId), result: completion)
    }
}
