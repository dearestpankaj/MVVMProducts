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
            type: ProductEndPoint.products) { response in
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
    
    func addProduct(parameters: AddProduct) {
        APIManager.shared.request(modelType: AddProduct.self, type: ProductEndPoint.addProduct(product: parameters)) { result in
            switch result {
            case .success(let product):
                self.eventHandler?(.newProductAdded(product: product))
            case .failure(let error):
                self.eventHandler?(.error(error))
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
        case newProductAdded(product: AddProduct)
    }
}
