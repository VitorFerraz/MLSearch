//
//  ViewController.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DetailRemoteRepository().fetchDetail(productId: "MLB1742066740") { result in
            dump(result)
        }
    }


}

