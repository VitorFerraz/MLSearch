//
//  DetailPresenter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol DetailPresenterProtocol {
    func onViewDidLoad()
    func getViewModel() -> DetailViewModel?
    func openExternalLink(link: URL?)
}

final class DetailPresenter {
    typealias Interactor = DetailInteractor
    typealias Router = DetailRouter
    
    var interactor: DetailInteractor
    var router: DetailRouter
    weak var view: DetailViewControllerProtocol?
    private var id: String = ""
    var viewModel: DetailViewModel?
    
    init(_ interactor: DetailInteractor, _ router: DetailRouter, id: String) {
        self.interactor = interactor
        self.router = router
        self.id = id
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func openExternalLink(link: URL?) {
        router.openExternalLink(link: link)
    }
    
    func getViewModel() -> DetailViewModel? {
        viewModel
    }
    
    func onViewDidLoad() {
        interactor.productDetail(for: id)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func showLoading() {
        view?.showLoading()
    }
    
    func showResult(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        view?.showResult()
    }
    
    func showError(with message: String) {
        view?.showError(with: message)
    }
}
