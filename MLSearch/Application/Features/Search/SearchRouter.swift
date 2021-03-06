//
//  SearchRouter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit
import DesignSystem

protocol SearchRouterProtocol: Router {
    func showProductDetail(_ viewModel: ProductViewModel)
    static func buildStructure(repository: SearchRepository) -> UIViewController 
}

final class SearchRouter: SearchRouterProtocol {
    var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    static func buildStructure(repository: SearchRepository = SearchRemoteRepository()) -> UIViewController {
        let viewController = SearchViewController()
        let router  = SearchRouter(rootViewController: viewController)
        let interactor  = SearchInteractor(repository: repository)
        let presenter = SearchPresenter(interactor, router)
        interactor.output = presenter
        presenter.view = viewController
        viewController.presenter = presenter
        let rootViewController : UINavigationController = UINavigationController(rootViewController: viewController)
        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.backgroundColor = StyleGuide.Color.primary
        rootViewController.navigationBar.barTintColor = StyleGuide.Color.primary
        rootViewController.navigationBar.tintColor = StyleGuide.Color.primary
        return rootViewController
    }
    
    func showProductDetail(_ viewModel: ProductViewModel) {
        rootViewController?.present(DetailRouter.buildStructure(productId: viewModel.id), animated: true, completion: nil)
    }
}
