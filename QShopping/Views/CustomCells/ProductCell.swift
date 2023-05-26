//
//  ProductCell.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 4.05.2023.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var selectedProduct: Product?
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
        CartManager.shared.addToCart(selectedProduct!)
    }
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        FavoriteManager.shared.toggleFavorite(selectedProduct!)
        let isProductInFavorite = FavoriteManager.shared.isProductIDInFavorites(selectedProduct!.id)
        let favImage = isProductInFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: favImage), for: .normal)
    }
}
