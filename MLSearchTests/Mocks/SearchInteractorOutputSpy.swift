//
//  SearchInteractorOutputSpy.swift
//  MLSearchTests
//
//  Created by Vitor Ferraz Varela on 14/02/21.
//
@testable import MLSearch
import Foundation

class SearchInteractorOutputSpy: SearchInteractorOutputProtocol {
    var didCallShowLoading = false
    var didCallShowResults = false
    var withViewModels: [ProductViewModel]?
    var withErrorMessage: String?
    var didShowError = false
    
    func showLoading() {
        didCallShowLoading = true
    }
    
    func showResults(viewModels: [ProductViewModel]) {
        withViewModels = viewModels
        didCallShowResults = true
    }
    
    func showError(with message: String) {
        withErrorMessage = message
        didShowError = true
    }
}
