//
//  FavoriteManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 25.05.2023.
//

import Foundation

class FavoriteManager {
    static let shared = FavoriteManager()
    
    var products: [Product] = []
    
    
    var favoriteItemCount: Int {
        return products.count
    }
    
    func item(at index: Int) -> Product? {
        guard index >= 0 && index < products.count else {
            return nil
        }
        return products[index]
    }
    
    func toggleFavorite(_ product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products.remove(at: index)
        } else {
            products.append(product)
        }
    }
    
    func isProductIDInFavorites(_ productID: Int) -> Bool {
        return products.contains(where: { $0.id == productID })
    }

}