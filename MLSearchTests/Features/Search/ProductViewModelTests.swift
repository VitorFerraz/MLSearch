@testable import MLSearch
import Quick
import Nimble
import UIKit

final class ProductViewModelTests: QuickSpec {
    var sut: ProductViewModel!
    var model: SearchResult!
    
    fileprivate func setupViewModel(withFreeShipping freeShipping: Bool = true) {
        self.model = SearchResult(id: "123", price: 10, thumbnail: "https://www.google.com/jpg", title: "teste", shipping: .init(freeShipping: freeShipping))
        self.sut = ProductViewModel(self.model)
    }
    
    override func spec() {
        beforeEach {
            self.setupViewModel()
        }
        
        describe("view model") {
            context("when initialized with search result model with freeShipping") {
                it("should format the information") {
                    expect(self.sut.name).to(equal("teste"))
                    expect(self.sut.id).to(equal("123"))
                    expect(self.sut.image).to(equal("https://www.google.com/jpg"))
                    expect(self.sut.freeShipping).to(equal("ENTREGA GRATUITA"))
                    expect(self.sut.price).to(equal("R$ 10,00"))
                }
            }
            context("when initialized with search result model without freeShipping") {
                setupViewModel(withFreeShipping: false)
                
                expect(self.sut.name).to(equal("teste"))
                expect(self.sut.id).to(equal("123"))
                expect(self.sut.image).to(equal("https://www.google.com/jpg"))
                expect(self.sut.freeShipping).to(equal("CONSULTE O VALOR DO FRETE"))
                expect(self.sut.price).to(equal("R$ 10,00"))
            }
        }
    }
}
