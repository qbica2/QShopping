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
    }
    struct cells {
        static let testerCell = "testerCell"
        static let productCell = "productCell"
    }
    struct Alert {
        static let errorTitle = "Error!"
        static let defaultButtonTitle = "OK"
        static let cancelButtonTitle = "CANCEL"
    }
}
