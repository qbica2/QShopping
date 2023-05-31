//
//  User.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 27.04.2023.
//

import Foundation

struct User {
    let id: Int
    let email: String
    let username: String
    let password: String
    let firstname: String
    let lastname: String
    
    var fullname: String {
        return "\(firstname) \(lastname)"
    }
}
