//
//  DetailViewModel.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 12/02/21.
//

import Foundation
struct DetailViewModel: Hashable {
    var model : ProductDetail
    
    var title: String {
        model.title ?? ""
    }
    
    var price: String {
        model.price?.currency ?? ""
    }
    
    var freeShipping: String {
        model.shipping.freeShipping ? "FRETE GRATUITO" : ""
    }
    
    var link: URL? {
        URL(string: model.permalink)
    }
    
    var image: String? {
        model.thumbnail
    }
    
    var address: String {
        guard let city = model.sellerAddress.city?.name,
              let state = model.sellerAddress.state?.name else {
            return "Não informado"
        }
        
        return "Cidade: \(city), Estado: \(state)"
    }
}
