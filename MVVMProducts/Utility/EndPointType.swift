//
//  EndpointType.swift
//  MVVMProducts
//
//  Created by Pankaj Sachdeva on 05.12.23.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
}

enum EndPointItems {
    case products
}

extension EndPointItems: EndPointType {
    var path: String {
        switch self {
        case .products:
            return "products"
        }
    }
    
    var baseURL: String {
        "https://fakestoreapi.com/"
    }
    
    var url: URL? {
        URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        }
    }
    
}
