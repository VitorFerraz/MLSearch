//
//  SearchBarViewController.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 15/02/21.
//

import UIKit
class SearchBarViewController: ViewController {
    private lazy var productImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.constrainHeight(self.view.frame.height * 0.3)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    override func viewDidLoad() {
        setup()
    }
    
    override func addViewHierarchy() {
        view.addSubview(productImageView)
    }
    
    override func setupConstraints() {
        productImageView.centerInSuperview()
    }
}
