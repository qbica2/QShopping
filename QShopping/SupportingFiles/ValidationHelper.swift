//
//  ValidationHelper.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 29.04.2023.
//

import UIKit

class ValidationHelper {
    
    static func validateField(_ field: UITextField, errorLabel: UILabel) -> Bool {
        if field.text == "" {
            errorLabel.isHidden = false
            return false
        } else {
            errorLabel.isHidden = true
            return true
        }
    }
    
}
