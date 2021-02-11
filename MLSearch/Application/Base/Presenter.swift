//
//  Presenter.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol Presenter {
    associatedtype Interactor
    associatedtype Router
    var interactor: Interactor { get }
    var router: Router { get }

    init(_ interactor: Interactor, _ router: Router)
}
