//
//  CategoryManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 3.05.2023.
//
import Foundation

struct CategoryManager {
    let baseUrl = "https://fakestoreapi.com/products/categories"
    
    func getCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: baseUrl) else {
            completion(.failure(NSError(domain: "CategoryManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "CategoryManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown Error"])))
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([String].self, from: data)
                completion(.success(categories))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

