//
//  DetailRouter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit

final class DetailRouter: Router {
    var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    static func buildStructure(productId: String,repository: DetailRepository = DetailRemoteRepository()) -> UIViewController {
        let viewController = DetailViewController()
        let router  = DetailRouter(rootViewController: viewController)
        let interactor  = DetailInteractor(repository: repository)
        let presenter = DetailPresenter(interactor, router, id: productId)
        interactor.output = presenter
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
}

