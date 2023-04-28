//
//  UserCell.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 28.04.2023.
//

import UIKit

class UserCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
        
    @IBOutlet weak var loginLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loginLabel.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
