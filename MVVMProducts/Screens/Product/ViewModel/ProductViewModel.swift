//
//  ProductViewModel.swift
//  MVVMProducts
//
//  Created by Pankaj Sachdeva on 05.12.23.
//

import Foundation

final class ProductViewModel {
    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    
    func fetchProducts() {
        APIManager.shared.request(
            modelType: [Product].self,
            type: EndPointItems.products) { response in
                switch response {
                case .success(let products):
                    self.products = products
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                    print(error)
                }
            }
    }
}
extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
