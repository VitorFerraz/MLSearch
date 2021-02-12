//
//  ProductViewModel.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

struct ProductViewModel: Hashable {
    private let searchResult: SearchResult
    
    init(_ model: SearchResult) {
        self.searchResult = model
    }
    
    var id: String {
        searchResult.id
    }
    var name: String {
        searchResult.title
    }
    
    var image: String {
        searchResult.thumbnail
    }
    
    var freeShipping: String {
        searchResult.shipping.freeShipping ? "ENTREGA GRATUITA" : "CONSULTE O VALOR DO FRETE"
    }
    
    var price: String {
        searchResult.price?.toCurrency() ?? ""
    }
}
