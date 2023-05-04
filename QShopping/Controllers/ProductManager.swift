//
//  ProductManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 4.05.2023.
//

import Foundation


class ProductManager {
    let baseUrl = "https://fakestoreapi.com/products"
    var products: [ProductData] = []
    
    func getProducts(in categoryName: String?, completion: @escaping (Error?) -> Void ){
        var urlString = baseUrl
        
        if let categoryName = categoryName {
            urlString += "/category/\(categoryName)"
        }
        
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(error)
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                completion(error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data returned", code: 0, userInfo: nil)
                completion(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode([ProductData].self, from: data)
                self.products = products
                completion(nil)
            } catch {
                completion(error)
            }
        }
        task.resume()
    }
}
