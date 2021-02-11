//
//  DetailPresenter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol DetailPresenterProtocol {

}

final class DetailPresenter: Presenter {
    typealias Interactor = DetailInteractor
    typealias Router = DetailRouter
    
    var interactor: DetailInteractor
    var router: DetailRouter
    weak var view: DetailViewControllerProtocol?
    
    init(_ interactor: DetailInteractor, _ router: DetailRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    
}
