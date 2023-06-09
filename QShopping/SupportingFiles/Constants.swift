//
//  Constants.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 27.04.2023.
//

import Foundation

struct K {
    struct segues {
        static let landingToLogin = "landingToLogin"
        static let landingToRegister = "landingToRegister"
        static let landingToTester = "landingToTester"
        static let testerToLogin = "testerToLogin"
        static let loginToHome = "loginToHome"
        static let homeToDetail = "toDetailVC"
        static let cartToDetail = "cartToDetail"
        static let favoriteToDetail = "favToDetail"
    }
    struct cells {
        static let testerCell = "testerCell"
        static let productCell = "productCell"
        static let shoppingCartCell = "ShoppingCartCell"
        static let favoriteCell = "FavoriteCell"
    }
    struct Alert {
        static let errorTitle = "Error!"
        static let successTitle = "Success!"
        static let warningTitle = "Warning!"
        static let yesButtonTitle = "YES"
        static let defaultButtonTitle = "OK"
        static let cancelButtonTitle = "CANCEL"
    }
    struct NotificationName {
        static let cartUpdated = "CartUpdated"
        static let favUpdated = "FavoriteUpdated"
    }
}
