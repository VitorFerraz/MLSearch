//
//  SearchViewController.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    
}

final class SearchViewController: ViewController {
    var presenter: SearchPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    
}
