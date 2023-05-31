//
//  SettingsViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 29.05.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        
    }
    
    func updateUI(){
        accountImage.image = UIImage(systemName: "person.circle")
        nameLabel.text = SelectedTester.shared.user?.fullname
        emailLabel.text = SelectedTester.shared.user?.email
    }

    @IBAction func logoutPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
