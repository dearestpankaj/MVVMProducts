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
    
    func request<T: Decodable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
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
}
