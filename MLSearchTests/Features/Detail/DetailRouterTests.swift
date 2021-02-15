@testable import MLSearch
import Quick
import Nimble
import UIKit

final class DetailRouterTests: QuickSpec {
    var sut: DetailRouterProtocol!
    var rootViewController: UINavigationController!

    
    override func spec() {
        beforeEach {
            self.rootViewController = UINavigationController()
            self.sut = DetailRouterSpy()
        }
        
        describe("setup router") {
            context("with correct rootViewController") {
                it("should have a navigation controller as root") {
                    let rootViewController = DetailRouter.buildStructure(productId: "teste")
                    expect(rootViewController).to(beAKindOf(UINavigationController.self))
                }
            }
        }
        
        describe("navigation") {
            context("when user clicks on open link") {
                it("should open link on browser") {
                    self.sut.openExternalLink(link: nil)
                    let routerSpy = self.sut as? DetailRouterSpy
                    expect(routerSpy?.didOpenExternalLink).to(beTrue())
                }
            }
        }
    }
    
    class DetailRouterSpy: DetailRouterProtocol {
        var didOpenExternalLink = false
        var rootViewController: UIViewController?

        static func buildStructure(productId: String, repository: DetailRepository) -> UIViewController {
            UIViewController()
        }
        
        func openExternalLink(link: URL?) {
            didOpenExternalLink = true
        }
    }
}
