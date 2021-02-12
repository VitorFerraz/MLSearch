//
//  ProductDetail.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation

struct ProductDetail: Codable, Hashable {
    let id: String
    let title: String?
    let price: Double?
    let soldQuantity: Int
    let thumbnail: String?
    let permalink: String
    let shipping: Shipping
    let sellerAddress: SellerAddress

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case thumbnail
        case soldQuantity = "sold_quantity"
        case permalink
        case shipping
        case sellerAddress = "seller_address"
    }
}

struct SellerAddress: Codable, Hashable {
    struct City: Codable, Hashable {
        let name: String?
    }
    struct State: Codable, Hashable {
        let name: String?
    }
    let city: City?
    let state: State?
}
