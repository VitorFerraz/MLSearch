//
//  SearchPresenter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol SearchPresenterProtocol {
    var count: Int { get }
    func getViewModels() -> [ProductViewModel]
    func onDidSearchText(text: String)
    
}

final class SearchPresenter: Presenter {
    typealias Interactor = SearchInteractor
    typealias Router = SearchRouter
    var viewModels: [ProductViewModel] = []
    
    var count: Int {
        viewModels.count
    }
    
    var interactor: SearchInteractor
    var router: SearchRouter
    weak var view: SearchViewControllerProtocol?
    
    init(_ interactor: SearchInteractor, _ router: SearchRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func getViewModels() -> [ProductViewModel] {
        viewModels
    }
    
    func onDidSearchText(text: String) {
        interactor.searchProducts(by: text)
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
