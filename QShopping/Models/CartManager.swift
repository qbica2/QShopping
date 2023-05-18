//
//  ShoppingCartManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 16.05.2023.
//

import Foundation

protocol CartManagerDelegate {
    func didCartChange(_ cartManager: CartManager)
}

class CartManager {
    static let shared = CartManager()
        
    var products: [CartItem] = []
    var delegate: CartManagerDelegate?
    
    var cartItemCount: Int {
        return products.count
    }
    
    func item(at index: Int) -> CartItem? {
        guard index >= 0 && index < products.count else {
            return nil
        }
        return products[index]
    }
    
    func totalCartPrice() -> Double {
        var totalPrice: Double = 0.0
        
        for item in products {
            let productPrice = item.product.price
            let itemTotalPrice = productPrice * Double(item.quantity)
            totalPrice += itemTotalPrice
        }
        
        return totalPrice
    }
    
    func addToCart(_ product: Product, quantity: Int = 1) {
        if let existingItemIndex = products.firstIndex(where: { $0.product.id == product.id }) {
            products[existingItemIndex].quantity += quantity
        } else {
            let newItem = CartItem(product: product, quantity: quantity)
            products.append(newItem)
        }
        delegate?.didCartChange(self)
    }
    
    func deleteItemFromCart(at index: Int) {
        guard index >= 0 && index < products.count else {
            return
        }
        products.remove(at: index)
        delegate?.didCartChange(self)
    }

}

