//
//  DetailPresenterTests.swift
//  MLSearchTests
//
//  Created by Vitor Ferraz Varela on 15/02/21.
//

@testable import MLSearch
import Quick
import Nimble
import UIKit

final class DetailPresenterTests: QuickSpec {
    var sut: DetailPresenter!
    var view: DetailViewProtocolMock!
    var repository: DetailRepositoryMock!
    override func spec() {
        beforeEach {
            self.view = DetailViewProtocolMock()
            self.repository = DetailRepositoryMock()
            let interactor = DetailInteractor(repository: self.repository)
            self.sut = DetailPresenter(interactor, DetailRouter(rootViewController: UIViewController()), id: "teste")
            interactor.output = self.sut
            self.sut.view = self.view
        }
        
        describe("when user performs a search") {
            context("with product name") {
                it("should perform a search with correct name") {
                    let result = [ProductDetailResponse].parse(jsonFile: "DetailResult")!
                    self.repository.result = .success(result)

                    self.sut.onViewDidLoad()
                    
                    expect(self.view.didCallShowLoading).toEventually(beTrue())
                    expect(self.view.didCallShowResults).toEventually(beTrue())
                }
            }
            
            context("with error") {
                it("should return a error") {
                    self.repository.result = .failure(MyError.default)

                    self.sut.onViewDidLoad()
                    
                    expect(self.view.didCallShowLoading).toEventually(beTrue())
                    expect(self.view.didCallShowError).to(beTrue())
                    expect(self.view.withErrrorMessage).to(equal("error"))
                }
            }
        }
    }
    
    class DetailViewProtocolMock: DetailViewControllerProtocol {
       
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
        
        func showResult() {
            didCallShowResults = true
        }
    }
}


