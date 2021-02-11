//
//  SearchPresenter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol SearchPresenterProtocol {

}

final class SearchPresenter: Presenter {
    typealias Interactor = SearchInteractor
    typealias Router = SearchRouter
    
    var interactor: SearchInteractor
    var router: SearchRouter
    weak var view: SearchViewControllerProtocol?
    
    init(_ interactor: SearchInteractor, _ router: SearchRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
}
