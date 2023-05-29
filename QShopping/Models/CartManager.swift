//
//  ShoppingCartManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 16.05.2023.
//

import Foundation

protocol CartManagerDelegate {
    func didCartChange()
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
    
    func addToCart(_ product: Product, quantity: Int = 1, shouldNotify: Bool = true) {
        if let existingItemIndex = products.firstIndex(where: { $0.product.id == product.id }) {
            products[existingItemIndex].quantity += quantity
        } else {
            let newItem = CartItem(product: product, quantity: quantity)
            products.append(newItem)
        }
        if shouldNotify {
            NotificationCenter.default.post(name: NSNotification.Name(K.NotificationName.cartUpdated), object: nil)
        }
    }
    
    func changeQuantity(at index: Int, increment: Bool) {
        guard index >= 0 && index < products.count else {
            return
        }

        let item = products[index]
        let newQuantity = item.quantity + (increment ? 1 : -1)

        if newQuantity <= 0 {
            products.remove(at: index)
        } else {
            products[index].quantity = newQuantity
        }

        delegate?.didCartChange()
    }
    
    func clearCart() {
        products.removeAll()
        delegate?.didCartChange()
    }
    
    func deleteItemFromCart(id: Int) {
        if let index = products.firstIndex(where: { $0.product.id == id }) {
            products.remove(at: index)
            delegate?.didCartChange()
        }
    }
    
    func addMultipleProductsToCart(products: [Product]){
        for product in products {
            addToCart(product, shouldNotify: false)
        }
        NotificationCenter.default.post(name: NSNotification.Name(K.NotificationName.cartUpdated), object: nil)
    }
}

