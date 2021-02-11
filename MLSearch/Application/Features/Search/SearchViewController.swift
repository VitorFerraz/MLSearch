//
//  SearchViewController.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit
import DesignSystem

protocol SearchViewControllerProtocol: AnyObject {
    func showLoading()
    func showResults()
    func showError(with message: String)
}

final class SearchViewController: ViewController {
    var presenter: SearchPresenterProtocol?
    lazy var searchView: SearchView = {
        let searchView = SearchView(frame: .zero)
        searchView.delegate = self
        return searchView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func configureViews() {
        title = "Mercado Livre"
        navigationItem.searchController = searchView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        view.backgroundColor = StyleGuide.Color.primary
    }
    
    override func addViewHierarchy() {
        view.addSubview(searchView)
    }
    
    override func setupConstraints() {
        searchView.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
    }
    
}

extension SearchViewController: SearchViewControllerProtocol {
    func showLoading() {
        searchView.showLoading()
    }
    
    func showResults() {
        searchView.reloadData()
    }
    
    func showError(with message: String) {
        searchView.showError(with: message)
    }
}

extension SearchViewController: SearchViewDelegate {
    func getListCount() -> Int {
        presenter?.count ?? 0
    }
    
    func getViewModels() -> [ProductViewModel] {
        presenter?.getViewModels() ?? []
    }
    
    func didTapProduct(at index: Int) {
        //router
    }
    
    func didTapRetry(text: String) {
        presenter?.onDidSearchText(text: text)
    }
   
    func didTapSearch(text: String) {
        presenter?.onDidSearchText(text: text)
    }
}
