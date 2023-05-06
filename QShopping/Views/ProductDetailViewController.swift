//
//  ProductDetailViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 5.05.2023.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    var productManager = ProductManager()
    var alertManager = AlertManager()
    var selectedProductID: Int? {
        didSet{
            productManager.getProduct(id: selectedProductID!)
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addProductButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productManager.gettingProductDetailDelegate = self
        alertManager.delegate = self
        
    }

    @IBAction func favoritePressed(_ sender: UIButton) {
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
    }
    
    @IBAction func addProductButtonPressed(_ sender: UIButton) {
    }
}
//MARK: - GettingProductDetailDelegate

extension ProductDetailViewController: GettingProductDetailDelegate {
    func didSuccessGettingProductDetail(product: Product) {
        DispatchQueue.main.async {
            self.titleLabel.text = product.title
            self.descriptionLabel.text = product.description
            self.ratingLabel.text = String(product.rate)
            self.reviewLabel.text = "\(product.reviews) reviews"
            self.priceLabel.text = "$\(product.price)"
            
            let url = URL(string: product.imageURL)
            self.imageView.kf.setImage(with: url)
            self.addProductButton.subtitleLabel?.text = "$\(product.price)"
        }
    }
    
    func didFailGettingProductDetail(error: Error) {
        DispatchQueue.main.async {
            let alert = self.alertManager.errorAlert(for: error)
            self.alertManager.show(alert: alert)
        }
    }
    
}
//MARK: - AlertManagerDelegate

extension ProductDetailViewController: AlertManagerDelegate {
    func presentAlert(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
