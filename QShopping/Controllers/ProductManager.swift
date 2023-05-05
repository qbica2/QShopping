//
//  ProductManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 4.05.2023.
//

import Foundation

protocol GettingMultipleProductsDelegate {
    func didSuccessGettingMultipleProducts(_ productManager: ProductManager, products: [ProductData])
    func didFailGettingMultipleProducts(error: Error)
}

class ProductManager {
    let baseUrl = "https://fakestoreapi.com/products"
    var products: [ProductData] = []
    var gettingMultipleProductsDelegate: GettingMultipleProductsDelegate?
    
    func getProducts(categoryName: String? = nil){
        var urlString = baseUrl
        
        if let categoryName = categoryName {
            let encodedCategoryName = categoryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            urlString += "/category/\(encodedCategoryName)"
        }
        
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            gettingMultipleProductsDelegate?.didFailGettingMultipleProducts(error: error)
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                self.gettingMultipleProductsDelegate?.didFailGettingMultipleProducts(error: error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data returned", code: 0, userInfo: nil)
                self.gettingMultipleProductsDelegate?.didFailGettingMultipleProducts(error: error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode([ProductData].self, from: data)
                self.products = products
                self.gettingMultipleProductsDelegate?.didSuccessGettingMultipleProducts(self, products: self.products)
                
            } catch {
                self.gettingMultipleProductsDelegate?.didFailGettingMultipleProducts(error: error)
            }
        }
        task.resume()
    }
}
