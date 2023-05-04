//
//  HomeViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 2.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    var categoryManager = CategoryManager()
    var alertManager = AlertManager()
    
    @IBOutlet weak var categoriesScrollView: UIScrollView!
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertManager.delegate = self
        setupStackViewInScrollView()
        
        categoryManager.getCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
//                    self.createCategoryButtons(categories: categories)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = Alert(title: "Error", message: error.localizedDescription, firstButtonTitle: "OK", firstButtonStyle: UIAlertAction.Style.default, isSecondButtonActive: false, secondButtonTitle: "CANCEL", secondButtonStyle: UIAlertAction.Style.cancel, secondButtonHandler: nil)
                    self.alertManager.show(alert: alert)
                }
            }
        }
        
    }
    
    func setupStackViewInScrollView() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        categoriesScrollView.translatesAutoresizingMaskIntoConstraints = false
        categoriesScrollView.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        
        stackView.leadingAnchor.constraint(equalTo: categoriesScrollView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: categoriesScrollView.trailingAnchor, constant: -10).isActive = true
        stackView.centerYAnchor.constraint(equalTo: categoriesScrollView.centerYAnchor).isActive = true
    }
    


    

    
}
//MARK: - AlertManager Delegate

extension HomeViewController: AlertManagerDelegate {
    func presentAlert(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
