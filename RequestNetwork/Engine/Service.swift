//
//  Service.swift
//  Network
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation

public protocol Service {
    var baseURL:    URL { get }
    var path:       String { get }
    var httpMethod: HTTPMethod { get }
    var task:       HTTPTask { get }
    var headers:    HTTPHeaders? { get }
    var queryItems: [URLQueryItem] { get }
}

public typealias Parameters  = [String:Any]
public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case requestWith(bodyParameters: Parameters?)
}

public extension Service {
    var baseURL: URL {
        guard let url = URL(string: NetworkConstants.URLs.base) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders? {
        [NetworkConstants.HTTPHeaderField.contentType.rawValue: NetworkConstants.ContentType.json.rawValue]
    }
    
    var queryItems: [URLQueryItem] {
        []
    }
    
    var task: HTTPTask {
        .requestWith(bodyParameters: nil)
    }
    
    func createRequest() throws -> URLRequest {
        try buildRequestFrom(self)
    }
    
    func createUrl(_ service: Service) throws -> URL {
        var baseUrl: URL = service.baseURL
        
        if !service.path.isEmpty {
            baseUrl = service.baseURL.appendingPathComponent(service.path)
        }
        
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
            throw NetworkError.badRequest
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.badRequest
        }
        return url
    }
    
    func buildRequestFrom(_ service: Service) throws -> URLRequest {
        if ReachabilityManager.shared.connection == .unavailable {
            throw NetworkError.notConnected
        }
        
        do {
            let baseUrl = try createUrl(service)
            
            var request: URLRequest = URLRequest(url: baseUrl,
                                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                                 timeoutInterval: 10)
            request.httpMethod = service.httpMethod.rawValue
            request.allHTTPHeaderFields = service.headers
            
            switch task {
            case .requestWith(let bodyParameters):
                if let body = bodyParameters {
                    try JSONParameterEncoder.encode(urlRequest: &request, with: body)
                }
            }
            
            return request
        } catch let error {
            throw error
        }
    }
}
