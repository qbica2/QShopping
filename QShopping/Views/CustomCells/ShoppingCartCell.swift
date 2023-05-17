//
//  ShoppingCartCell.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 16.05.2023.
//

import UIKit

class ShoppingCartCell: UITableViewCell {
        
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var decreaseQuantityButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        itemImage.layer.cornerRadius = 8.0
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func quantityAction(_ sender: UIButton) {
        
//        var quantity = Int(quantityLabel.text!)!
//        
//        if sender.tag == 0 {
//            if quantity > 1 {
//                quantity -= 1
//            } else {
////                itemi sil
//            }
//        } else if sender.tag == 1 {
//            quantity += 1
//        }
//        
//        quantityLabel.text = String(quantity)
    }
    
}
