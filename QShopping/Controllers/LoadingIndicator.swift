//
//  LoadingIndicator.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 22.05.2023.
//

import Foundation
import JGProgressHUD

class LoadingIndicator {
    static let shared = LoadingIndicator() // Singleton oluşturuldu

    private var progressHUD: JGProgressHUD?

    private init() {
        // Gizli bir yapıcı metot, sınıfın yalnızca tek bir örneği olmasını sağlar
    }

    func show(in view: UIView) {
        DispatchQueue.main.async {
            if self.progressHUD == nil {
                self.progressHUD = JGProgressHUD(style: .dark)
                self.progressHUD?.textLabel.text = "Loading"
                self.progressHUD?.show(in: view)
            }
        }
    }

    func dismiss() {
        DispatchQueue.main.async {
            self.progressHUD?.dismiss()
            self.progressHUD = nil
        }
    }
}
