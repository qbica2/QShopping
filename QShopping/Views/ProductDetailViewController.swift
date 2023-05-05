//
//  ProductDetailViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 5.05.2023.
//

import UIKit

class ProductDetailViewController: UIViewController {

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

        // Do any additional setup after loading the view.
    }

    @IBAction func favoritePressed(_ sender: UIButton) {
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
    }
    
    @IBAction func addProductButtonPressed(_ sender: UIButton) {
    }
}
