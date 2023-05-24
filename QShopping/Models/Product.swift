//
//  Product.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 5.05.2023.
//

import Foundation

struct Product {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let imageURL: String
    let rate: Double
    let reviews: Int
    var islike: Bool
}
