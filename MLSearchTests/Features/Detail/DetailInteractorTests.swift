//
//  DetailInteractorTests.swift
//  MLSearchTests
//
//  Created by Vitor Ferraz Varela on 14/02/21.
//
@testable import MLSearch
import Quick
import Nimble
import UIKit

final class DetailInteractorTests: QuickSpec {
    var sut: DetailInteractor!
    var repositoryMock: DetailRepositoryMock!
    var outputMock: DetailInteractorOutputSpy!
    override func spec() {
        beforeEach {
            self.outputMock = DetailInteractorOutputSpy()
            self.repositoryMock = DetailRepositoryMock()
            self.sut = DetailInteractor(repository: self.repositoryMock)
            self.sut.output = self.outputMock
        }
        
        describe("when product detail is presented") {
            context("with a product id") {
                it("should return a valid response") {
                    let result = [ProductDetailResponse].parse(jsonFile: "DetailResult")!

                    self.repositoryMock.result = .success(result)
                    self.sut.productDetail(for: "teste")
                    
                    expect(self.outputMock.didCallShowLoading).toEventually(beTrue())
                    expect(self.outputMock.didCallShowResults).toEventually(beTrue())
                    expect(self.outputMock.withViewModel).toNotEventually(beNil())
                }
            }
            
            context("with a product id with error") {
                it("should return a error message") {
                    self.repositoryMock.result = .failure(MyError.default)

                    self.sut.productDetail(for: "teste")

                    expect(self.outputMock.didCallShowLoading).toEventually(beTrue())
                    expect(self.outputMock.didShowError).toEventually(beTrue())
                    expect(self.outputMock.withErrorMessage).to(equal("error"))
                }
            }
        }
    }
}
