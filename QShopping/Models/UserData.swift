//
//  User.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 27.04.2023.
//

import Foundation

struct UserData: Codable {
    let id: Int
    let email: String
    let username: String
    let password: String
    let name: Name
    let phone: String
    let address: Address
}

struct Name: Codable {
    let firstname: String
    let lastname: String
}

struct Address: Codable {
    let geolocation: Geolocation
    let city: String
    let street: String
    let number: Int
    let zipcode: String
}

struct Geolocation: Codable {
    let lat: String
    let long: String
}

