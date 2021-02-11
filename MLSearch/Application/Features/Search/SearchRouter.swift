//
//  SearchRouter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit

final class SearchRouter: Router {
    var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    static func buildStructure(repository: SearchRepository = SearchRemoteRepository()) -> UIViewController {
        let viewController = SearchViewController()
        let router  = SearchRouter(rootViewController: viewController)
        let interactor  = SearchInteractor()
        let presenter = SearchPresenter(interactor, router)
        interactor.output = presenter
        presenter.view = viewController
        viewController.presenter = presenter
        let rootViewController : UINavigationController = UINavigationController(rootViewController: viewController)
        rootViewController.navigationBar.prefersLargeTitles = true
        return rootViewController
    }
}
