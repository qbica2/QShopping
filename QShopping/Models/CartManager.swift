//
//  ShoppingCartManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 16.05.2023.
//

import Foundation

class CartManager {
    static let shared = CartManager()
        
    var products: [CartItem] = []
    
//    func addToCart(_ product: Product) {
//        if let existingItemIndex = products.firstIndex(where: { $0.product.id == product.id }) {
//            products[existingItemIndex].quantity += 1
//        } else {
//            let newItem = CartItem(product: product, quantity: 1)
//            products.append(newItem)
//        }
////        NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil)
//    }
}

