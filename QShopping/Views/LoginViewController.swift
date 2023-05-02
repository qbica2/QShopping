//
//  LoginViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 27.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var authManager = AuthManager()

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    var selectedTester: User?{
        didSet {
            DispatchQueue.main.async {
                self.usernameTextField.text = self.selectedTester?.username
                self.passwordTextField.text = self.selectedTester?.password
            }
        }
    }
    
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
        
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        authManager.login(with: username, with: password) { result in
            switch result {
            case .success(let token):
                print(token)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginWithTestPressed(_ sender: Any) {
    }
    
}
