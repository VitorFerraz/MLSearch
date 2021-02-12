//
//  DetailInteractor.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol DetailInteractorOutputProtocol: AnyObject {
    func showLoading()
    func showResult(viewModel: DetailViewModel)
    func showError(with message: String)
}

protocol DetailInteractorProtocol: AnyObject {
    func productDetail(for id: String)
}


final class DetailInteractor {
    private let repository: DetailRepository

    weak var output: DetailInteractorOutputProtocol?
    
    init(repository: DetailRepository) {
        self.repository = repository
    }
}

extension DetailInteractor: DetailInteractorProtocol {
    func productDetail(for id: String) {
        output?.showLoading()
        repository.fetchDetail(productId: id) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.output?.showError(with: error.localizedDescription)
            case .success(let response):
                guard let item = response.first?.body else {
                    self?.output?.showError(with: "Ops, produto não encontrado!")
                    return
                }
                let viewModel = DetailViewModel(model: item)
                self?.output?.showResult(viewModel: viewModel)
            }
        }
    }
    
    
}
