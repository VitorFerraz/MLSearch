//
//  DetailInteractorOutputSpy.swift
//  MLSearchTests
//
//  Created by Vitor Ferraz Varela on 14/02/21.
//

@testable import MLSearch
import Foundation

class DetailInteractorOutputSpy: DetailInteractorOutputProtocol {
    var didCallShowLoading = false
    var didCallShowResults = false
    var withViewModel: DetailViewModel?
    var withErrorMessage: String?
    var didShowError = false
    
    func showLoading() {
        didCallShowLoading = true
    }
    
    func showResult(viewModel: DetailViewModel) {
        withViewModel = viewModel
        didCallShowResults = true
    }
    
    func showError(with message: String) {
        withErrorMessage = message
        didShowError = true
    }
}
