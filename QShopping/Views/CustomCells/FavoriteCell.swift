//
//  FavoriteCell.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 23.05.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var selectedProduct: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        FavoriteManager.shared.toggleFavorite(selectedProduct!)
    }
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
        CartManager.shared.addToCart(selectedProduct!)
    }
    
    
}
