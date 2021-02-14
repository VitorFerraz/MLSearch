@testable import MLSearch
import Quick
import Nimble
import UIKit

final class SearchPresenterTests: QuickSpec {
    var sut: SearchPresenter!
    var view: SearchViewProtocolMock!
    var repository: SearchRepositoryMock!
    override func spec() {
        beforeEach {
            self.view = SearchViewProtocolMock()
            self.repository = SearchRepositoryMock()
            let interactor = SearchInteractor(repository: self.repository)
            self.sut = SearchPresenter(interactor, SearchRouter(rootViewController: UIViewController()))
            interactor.output = self.sut
            self.sut.view = self.view
            
        }
        
        describe("when user performs a search") {
            context("with product name") {
                it("should perform a search with correct name") {
                    let result = SearchResponse.parse(jsonFile: "SearchResults")!
                    self.repository.result = .success(result)

                    self.sut.onDidSearchText(text: "teste")
                    
                    expect(self.view.didCallShowLoading).toEventually(beTrue())
                    expect(self.view.didCallShowResults).toEventually(beTrue())
                }
            }
            
            context("with invalid product name") {
                it("should return a empty error") {
                    self.sut.onDidSearchText(text: "")
                    
                    expect(self.view.didCallShowError).to(beTrue())
                    expect(self.view.withErrrorMessage).to(equal("Ops, é necessário informar um título válido"))
                }
            }
            
            context("with error") {
                it("should return a error") {
                    self.repository.result = .failure(MyError.default)

                    self.sut.onDidSearchText(text: "teste")
                    
                    expect(self.view.didCallShowLoading).toEventually(beTrue())
                    expect(self.view.didCallShowError).to(beTrue())
                    expect(self.view.withErrrorMessage).to(equal("error"))
                }
            }
        }
    }
    
    class SearchViewProtocolMock: SearchViewControllerProtocol {
      
        var didCallShowLoading = false
        var didCallShowError = false
        var didCallShowResults = false
        var withErrrorMessage: String?
        
        func showLoading() {
            didCallShowLoading = true
        }
        
        func showError(with message: String) {
            didCallShowError = true
            withErrrorMessage = message
        }
        
        func showResults() {
            didCallShowResults = true
        }
    }
}


