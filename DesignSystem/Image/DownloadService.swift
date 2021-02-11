//
//  DownloadService.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation
import RequestNetwork

enum DownloadService {
    case downloadImageFrom(url: URL)
}

extension DownloadService: Service {
    var baseURL: URL {
        switch self {
        case .downloadImageFrom(let url):
            return url
        }
    }
    
    var path: String {
        ""
    }
}
