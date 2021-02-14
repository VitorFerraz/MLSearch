//
//  DetailViewModelTests.swift
//  MLSearchTests
//
//  Created by Vitor Ferraz Varela on 14/02/21.
//

@testable import MLSearch
import Quick
import Nimble
import UIKit

final class DetailViewModelTests: QuickSpec {
    var sut: DetailViewModel!
    var model: ProductDetail!
    
    fileprivate func setupViewModel(withFreeShipping freeShipping: Bool = true) {
        self.model = ProductDetail(id: "123", title: "teste", price: 10, soldQuantity: 10, thumbnail: "https://www.google.com/jpg", permalink: "https://www.google.com", shipping: .init(freeShipping: true), sellerAddress: .init(city: .init(name: "guarulhos"), state: .init(name: "sao paulo")))
        self.sut = DetailViewModel(model: self.model)
    }
    
    override func spec() {
        beforeEach {
            self.setupViewModel()
        }
        
        describe("view model") {
            context("when initialized with search result model with freeShipping") {
                it("should format the information") {
                    expect(self.sut.title).to(equal("teste"))
                    expect(self.sut.address).to(equal("Cidade: guarulhos, Estado: sao paulo"))
                    expect(self.sut.image).to(equal("https://www.google.com/jpg"))
                    expect(self.sut.freeShipping).to(equal("FRETE GRATUITO"))
                    expect(self.sut.price).to(equal("R$ 10,00"))
                }
            }
            context("when initialized with search result model without freeShipping") {
                setupViewModel(withFreeShipping: false)
                
                expect(self.sut.title).to(equal("teste"))
                expect(self.sut.address).to(equal("Cidade: guarulhos, Estado: sao paulo"))
                expect(self.sut.image).to(equal("https://www.google.com/jpg"))
                expect(self.sut.freeShipping).to(equal(""))
                expect(self.sut.price).to(equal("R$ 10,00"))
            }
        }
    }
}
