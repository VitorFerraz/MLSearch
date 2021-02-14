@testable import MLSearch
import Quick
import Nimble
import UIKit

final class SearchInteractorTests: QuickSpec {
    var sut: SearchInteractor!
    var repositoryMock: SearchRepositoryMock!
    var outputMock: SearchInteractorOutputSpy!
    override func spec() {
        beforeEach {
            self.outputMock = SearchInteractorOutputSpy()
            self.repositoryMock = SearchRepositoryMock()
            self.sut = SearchInteractor(repository: self.repositoryMock)
            self.sut.output = self.outputMock
        }
        
        describe("when use performs a search") {
            context("with a product name") {
                it("should return a valid response") {
                    let result = SearchResponse.parse(jsonFile: "SearchResults")!

                    self.repositoryMock.result = .success(result)
                    self.sut.searchProducts(by: "teste")
                    
                    expect(self.outputMock.didCallShowLoading).toEventually(beTrue())
                    expect(self.outputMock.didCallShowResults).toEventually(beTrue())
                    expect(self.outputMock.withViewModels).toNotEventually(beNil())
                }
            }
            
            context("with a product name with error") {
                it("should return a error message") {
                    self.repositoryMock.result = .failure(MyError.default)

                    self.sut.searchProducts(by: "teste")
                    
                    expect(self.outputMock.didCallShowLoading).toEventually(beTrue())
                    expect(self.outputMock.didShowError).toEventually(beTrue())
                    expect(self.outputMock.withErrorMessage).to(equal("error"))
                }
            }
        }
    }
}


enum MyError: Error {
    case `default`
    
    
}
extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .default:
            return "error"
        }
    }
}
