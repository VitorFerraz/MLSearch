//
//  SearchPresenter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol SearchPresenterProtocol {
    func getViewModels() -> [ProductViewModel]
    func onDidSearchText(text: String)
    func showProductDetail(viewModel: ProductViewModel)
    
}

final class SearchPresenter: Presenter {
    typealias Interactor = SearchInteractor
    typealias Router = SearchRouterProtocol
    var viewModels: [ProductViewModel] = []
    
    var interactor: SearchInteractor
    var router: SearchRouterProtocol
    weak var view: SearchViewControllerProtocol?
    
    init(_ interactor: SearchInteractor, _ router: SearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func showProductDetail(viewModel: ProductViewModel) {
        router.showProductDetail(viewModel)
    }
    
    func getViewModels() -> [ProductViewModel] {
        viewModels
    }
    
    func onDidSearchText(text: String) {
        if text.isEmpty {
            view?.showError(with: "Ops, é necessário informar um título válido")
        } else {
            interactor.searchProducts(by: text)
        }
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func showResults(viewModels: [ProductViewModel]) {
        self.viewModels = viewModels
        view?.showResults()
    }
    
    func showLoading() {
        view?.showLoading()
    }
    
    func showError(with message: String) {
        view?.showError(with: message)
    }
}
