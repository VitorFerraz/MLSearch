@testable import MLSearch
import Quick
import Nimble
import UIKit

final class SearchRouterTests: QuickSpec {
    var sut: SearchRouterProtocol!
    var rootViewController: UINavigationController!

    
    override func spec() {
        beforeEach {
            self.rootViewController = UINavigationController()
            self.sut = SearchRouterSpy()
        }
        
        describe("setup router") {
            context("with correct rootViewController") {
                it("should have a navigation controller as root") {
                    let rootViewController = SearchRouter.buildStructure()
                    expect(rootViewController).to(beAKindOf(UINavigationController.self))
                }
            }
        }
        
        describe("navigation") {
            context("when user clicks on product") {
                fit("should call show product detail") {
                    self.sut.showProductDetail(.init(.init(id: "", price: 0, thumbnail: "", title: "", shipping: .init(freeShipping: false))))
                    let routerSpy = self.sut as? SearchRouterSpy
                    expect(routerSpy?.didCallShowProductDetail).to(beTrue())
                }
            }
        }
    }
    
    class SearchRouterSpy: SearchRouterProtocol {
        var didCallShowProductDetail = false
        
        static func buildStructure(repository: SearchRepository) -> UIViewController {
            UIViewController()
        }
        
        func showProductDetail(_ viewModel: ProductViewModel) {
            didCallShowProductDetail = true
        }
        
        var rootViewController: UIViewController?
    }
    
}
