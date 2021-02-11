//
//  DetailViewController.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    
}

final class DetailViewController: ViewController {
    var presenter: DetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
}
