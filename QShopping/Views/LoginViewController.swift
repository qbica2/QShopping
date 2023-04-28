//
//  LoginViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 27.04.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        for view in [usernameView,passwordView] {
            view?.layer.cornerRadius = 12
            view?.layer.masksToBounds = true
        }
        usernameErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }

    @IBAction func loginPressed(_ sender: UIButton) {
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginWithTestPressed(_ sender: Any) {
    }
    
}
