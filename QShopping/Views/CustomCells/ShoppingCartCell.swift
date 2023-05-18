//
//  ShoppingCartCell.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 16.05.2023.
//

import UIKit

protocol ShoppingCartCellDelegate {
    func deleteButtonTapped(at index: Int)
}

class ShoppingCartCell: UITableViewCell {
        
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var decreaseQuantityButton: UIButton!
    
    var delegate: ShoppingCartCellDelegate?
    
    var index: Int?
    var productQuantity: Int? {
        didSet {
            DispatchQueue.main.async {
                if self.productQuantity == 1 {
                    self.decreaseQuantityButton.setImage(UIImage(systemName: "trash"), for: .normal)
                } else {
                    self.decreaseQuantityButton.setImage(UIImage(systemName: "minus.circle"), for: .normal)
                }
            }
        }
    }

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
        
        guard var quantity = productQuantity else {
             return
         }

         if sender.tag == 0 {
             if quantity > 1 {
                 quantity -= 1
             } else if quantity == 1 {
                 delegate?.deleteButtonTapped(at: index!)
             }
         } else if sender.tag == 1 {
             quantity += 1
         }

         productQuantity = quantity
         quantityLabel.text = String(quantity)
    }
    
}
