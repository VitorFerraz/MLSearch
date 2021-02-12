//
//  SearchInteractor.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol SearchInteractorOutputProtocol: AnyObject {
    func showLoading()
    func showResults(viewModels: [ProductViewModel])
    func showError(with message: String)
}

protocol SearchInteractorProtocol: AnyObject {
    func searchProducts(by name: String)
}


final class SearchInteractor {
    private let repository: SearchRepository
    weak var output: SearchInteractorOutputProtocol?
    
    init(repository: SearchRepository) {
        self.repository = repository
    }
}

extension SearchInteractor: SearchInteractorProtocol {
    func searchProducts(by name: String) {
        output?.showLoading()
        repository.fetchProducts(by: name) { [weak output] result in
            switch result {
            case .failure(let error):
                output?.showError(with: error.localizedDescription)
            case .success(let response):
                let viewModels = response.results.map(ProductViewModel.init)
                output?.showResults(viewModels: viewModels)
            }
        }
    }
}
