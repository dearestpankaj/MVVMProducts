//
//  APIManager.swift
//  MVVMProducts
//
//  Created by Pankaj Sachdeva on 05.12.23.
//
import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case invalidData
    case network(Error?)
}

typealias Handler<T> = (Result<T, DataError>) -> Void

final class APIManager {
    static let shared = APIManager()
    private init() { }
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        request.allHTTPHeaderFields = type.header
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode(modelType, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json "
        ]
    }
}
