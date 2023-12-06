//
//  ProductEndPoint.swift
//  MVVMProducts
//
//  Created by Pankaj Sachdeva on 06.12.23.
//

import Foundation

enum ProductEndPoint {
    case products
    case addProduct(product: AddProduct)
}

extension ProductEndPoint: EndPointType {
    var body: Encodable? {
        switch self {
        case .products:
            return "products"
        case .addProduct(let product):
            return product
        }
    }
    
    var header: [String : String]? {
        return APIManager.commonHeaders
    }
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case .addProduct:
            return "products/add"
        }
    }
    
    var baseURL: String {
        switch self {
            
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://dummyjson.com/"
        }
        
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }
    
}
