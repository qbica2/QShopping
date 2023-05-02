//
//  AlertManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 2.05.2023.
//

import Foundation
import UIKit

protocol AlertManagerDelegate {
    func presentAlert(alertController: UIAlertController)
}

struct AlertManager {
    
    var delegate : AlertManagerDelegate?
    
    func show(alert: Alert){
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.preferredStyle)
        let firstButton = UIAlertAction(title: alert.firstButtonTitle, style: alert.firstButtonStyle)
        
        alertController.addAction(firstButton)
        
        if alert.isSecondButtonActive {
            let secondButton = UIAlertAction(title: alert.secondButtonTitle, style: alert.secondButtonStyle) { _ in
                alert.secondButtonHandler?()
            }
            alertController.addAction(secondButton)
        }

        
        delegate?.presentAlert(alertController: alertController)
        
    }
}
