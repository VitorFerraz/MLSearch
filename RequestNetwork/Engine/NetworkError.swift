//
//  NetworkError.swift
//  Network
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation

public enum NetworkError: String, Error {
    case authentication
    case badRequest
    case failed
    case noData
    case decode
    case notConnected
    
    var description: String {
        return rawValue
    }
}
