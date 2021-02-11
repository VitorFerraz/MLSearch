//
//  DetailInteractor.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol DetailInteractorOutputProtocol: AnyObject {
   
}

protocol DetailInteractorProtocol: AnyObject {
   
}


final class DetailInteractor {
    weak var output: DetailInteractorOutputProtocol?

}

extension DetailInteractor: DetailInteractorProtocol {
    
}
