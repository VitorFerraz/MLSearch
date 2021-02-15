//
//  DetailRepositoryMock.swift
//  MLSearchTests
//
//  Created by Vitor Ferraz Varela on 14/02/21.
//

import Foundation
@testable import MLSearch

class DetailRepositoryMock: DetailRepository {
    var result: (Result<[ProductDetailResponse], Error>)!
    var didCallFetchDetail = false

    func fetchDetail(productId: String, completion: @escaping (Result<[ProductDetailResponse], Error>) -> Void) {
        didCallFetchDetail = true
        completion(result)
    }
}
