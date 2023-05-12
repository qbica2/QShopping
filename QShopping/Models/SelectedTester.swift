//
//  SelectedTester.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 12.05.2023.
//

import Foundation

class SelectedTester {
    static let shared = SelectedTester()
    
    var user: User?
    
    private init() {}
}
