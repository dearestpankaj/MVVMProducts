//
//  AddProductsViewController.swift
//  MVVMProducts
//
//  Created by Pankaj Sachdeva on 05.12.23.
//

import UIKit

class AddProductsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addProduct()
    }
    
    private func addProduct() {
        guard let url = URL(string: "https://dummyjson.com/products/add") else { return }
        let parameter = AddProduct(title: "BMW Car")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(parameter)
        request.allHTTPHeaderFields = [
            "Content-Type" : "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                let productResponse = try JSONDecoder().decode(AddProduct.self, from: data)
                print(productResponse)
                
            } catch {
                print(error)
            }
            
        }.resume()
    }
}
