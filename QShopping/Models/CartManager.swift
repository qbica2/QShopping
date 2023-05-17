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
    
    func addToCart(_ product: Product, quantity: Int = 1) {
        if let existingItemIndex = products.firstIndex(where: { $0.product.id == product.id }) {
            products[existingItemIndex].quantity += quantity
        } else {
            let newItem = CartItem(product: product, quantity: quantity)
            products.append(newItem)
        }
        NotificationCenter.default.post(name: NSNotification.Name("ProductAdded"), object: nil)
    }
}

