//
//  ProductDetail.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation

struct ProductDetail: Codable {
    let id: String
    let title: String?
    let price: Double?
    let soldQuantity: Int
    let pictures: [ProductDetailPicture]

    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case price
        case pictures
        case soldQuantity = "sold_quantity"
    }
}


struct ProductDetailPicture: Codable {
    let id: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case url = "secure_url"
    }
}

