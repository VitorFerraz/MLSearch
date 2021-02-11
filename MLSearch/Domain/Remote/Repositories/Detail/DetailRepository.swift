//
//  DetailRepository.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation
protocol DetailRepository {
    func fetchDetail(productId: String, completion: @escaping (Result<[ProductDetailResponse], Error>) -> Void)
}
