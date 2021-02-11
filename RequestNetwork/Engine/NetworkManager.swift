//
//  NetworkManager.swift
//  Network
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import UIKit

public typealias RouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void
public typealias ResultCompletion<T> = (Result<T, Error>) -> Void

public protocol NetworkProtocol {
    associatedtype S: Service
    func request<T: Decodable>(service: S, result: @escaping ResultCompletion<T>)
    func downloadImage(service: S,result: @escaping (Result<UIImage, Error>) -> Void)
}


public final class NetworkManager<S: Service>: NetworkProtocol {
    private var task: URLSessionTask?
    private let imageCache: NSCache = NSCache<NSString, UIImage>()
    
    public init() {}
    
    public func request<T>(service: S, result: @escaping ResultCompletion<T>) where T : Decodable {
            perform(service) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        return result(.failure(error))
                    }
                    
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                        return result(.failure(NetworkError.badRequest))
                    }
                    
                    switch statusCode {
                    case 200...299:
                        guard let data = data else {
                            return result(.failure(NetworkError.noData))
                        }
                        do {
                            let decoder: JSONDecoder = .init()
                            decoder.dateDecodingStrategy = .iso8601
                            let objectDecodabled = try decoder.decode(T.self, from: data)
                            return result(.success(objectDecodabled))
                        } catch {
                            print(error)
                            return result(.failure(NetworkError.decode))
                        }
                    default:
                        return result(.failure(NetworkError.failed))
                    }
                }
            }
    }
    
    private func perform(_ service: Service, completion: @escaping RouterCompletion) {
        let session: URLSession = .shared
        
        do {
            let request = try service.createRequest()
            task = session.dataTask(with: request, completionHandler: { (data, urlResponse, error) in
                completion(data, urlResponse, error)
            })
        } catch let error {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    public func downloadImage(service: S,result: @escaping (Result<UIImage, Error>) -> Void) {
        if let imageCached = imageCache.object(forKey: NSString(string: service.baseURL.absoluteString)) {
            result(.success(imageCached))
            return
        }
        
        perform(service) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    return result(.failure(error))
                }
                
                guard let response = response as? HTTPURLResponse else {
                    return result(.failure(NetworkError.badRequest))
                }
                
                switch response.statusCode {
                case 200...299:
                    guard let responseData = data else {
                        return result(.failure(NetworkError.noData))
                        
                    }
                    
                    guard let objectDecodabled = UIImage(data: responseData) else {
                        return result(.failure(NetworkError.decode))
                        
                    }
                    result(.success(objectDecodabled))
                    self.imageCache.setObject(objectDecodabled, forKey: NSString(string: service.baseURL.absoluteString))
                default:
                    return result(.failure(NetworkError.failed))

                }
            }
        }
    }
}


