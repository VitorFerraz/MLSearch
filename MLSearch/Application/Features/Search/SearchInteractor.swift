//
//  SearchInteractor.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation

protocol SearchInteractorOutputProtocol: AnyObject {
   
}

protocol SearchInteractorProtocol: AnyObject {
   
}


final class SearchInteractor {
    weak var output: SearchInteractorOutputProtocol?

}

extension SearchInteractor: SearchInteractorProtocol {
    
}
