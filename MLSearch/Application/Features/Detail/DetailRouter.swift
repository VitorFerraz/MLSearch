//
//  DetailRouter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit

protocol DetailRouterProtocol: Router {
    static func buildStructure(productId: String,repository: DetailRepository) -> UIViewController
    func openExternalLink(link: URL?)
}

final class DetailRouter: DetailRouterProtocol {
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
    
    func openExternalLink(link: URL?) {
        guard let url = link else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

