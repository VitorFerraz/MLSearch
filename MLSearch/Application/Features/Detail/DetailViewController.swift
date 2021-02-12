//
//  DetailViewController.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func showLoading()
    func showResult()
    func showError(with message: String)
}

final class DetailViewController: ViewController {
    var presenter: DetailPresenterProtocol?
    lazy var detailView: DetailView = {
        let detailView = DetailView(frame: .zero)
        detailView.delegate = self
        return detailView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.onViewDidLoad()
    }
    
    override func configureViews() {
        title = "Detalhes"
    }
    
    override func addViewHierarchy() {
        view.addSubview(detailView)
    }
    
    override func setupConstraints() {
        detailView.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func showLoading() {
        detailView.showLoading()
    }
    
    func showResult() {
        detailView.reloadData()
    }
    
    func showError(with message: String) {
        detailView.showError(with: message)
    }
}

extension DetailViewController: DetailViewDelegate {
    func getViewModel() -> DetailViewModel? {
        presenter?.getViewModel()
    }
}
