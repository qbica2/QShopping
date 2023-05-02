//
//  Alert.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 2.05.2023.
//

import Foundation
import UIKit

struct Alert {
    let title: String
    let message: String
    let preferredStyle: UIAlertController.Style = .alert
    let firstButtonTitle: String
    let firstButtonStyle: UIAlertAction.Style
    let isSecondButtonActive: Bool
    let secondButtonTitle: String
    let secondButtonStyle: UIAlertAction.Style
    let secondButtonHandler: (() -> Void)?
}
