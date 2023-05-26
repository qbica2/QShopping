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
    let loadingView = LoadingIndicator.shared
    
    var selectedProductID: Int? {
        didSet{
            productManager.getProduct(id: selectedProductID!)
        }
    }
    
    var selectedProduct: Product? {
        didSet {
            updateUI()
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
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productManager.gettingProductDetailDelegate = self
        alertManager.delegate = self
        loadingView.show(in: self.view)

    }
    
    func updateUI(){
        DispatchQueue.main.async {
            self.loadingView.dismiss()
            self.titleLabel.text = self.selectedProduct!.title
            self.descriptionLabel.text = self.selectedProduct!.description
            self.ratingLabel.text = String(self.selectedProduct!.rate)
            self.reviewLabel.text = "\(self.selectedProduct!.reviews) reviews"
            self.priceLabel.text = "$\(self.selectedProduct!.price)"
            
            let url = URL(string: self.selectedProduct!.imageURL)
            self.imageView.kf.setImage(with: url)
            self.totalPriceLabel.text = "Total Price: $ \(self.selectedProduct!.price)"
        }
    }

    @IBAction func favoritePressed(_ sender: UIButton) {
        FavoriteManager.shared.toggleFavorite(selectedProduct!)
        let isProductInFavorite = FavoriteManager.shared.isProductIDInFavorites(selectedProduct!.id)
        let favImage = isProductInFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: favImage), for: .normal)
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        let stepperValue = Int(sender.value)
        let totalPrice = selectedProduct!.price * sender.value
        let formattedPrice = String(format: "%.2f", totalPrice)
        
        DispatchQueue.main.async {
            self.countTextField.text = String(stepperValue)
            self.totalPriceLabel.text = "Total Price: $ \(formattedPrice)"
        }
        
    }
    
    @IBAction func addProductButtonPressed(_ sender: UIButton) {
        let quantity = Int(countTextField.text!)!
        CartManager.shared.addToCart(selectedProduct!, quantity: quantity)
        stepper.value = 1.0
        DispatchQueue.main.async {
            self.countTextField.text = "1"
            self.totalPriceLabel.text = "Total Price: $ \(self.selectedProduct!.price)"
            
        }
    }
}
//MARK: - GettingProductDetailDelegate

extension ProductDetailViewController: GettingProductDetailDelegate {
    func didSuccessGettingProductDetail(product: Product) {
        selectedProduct = product
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
