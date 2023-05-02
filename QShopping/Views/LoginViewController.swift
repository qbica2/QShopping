//
//  LoginViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 27.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var authManager = AuthManager()
    var alertManager = AlertManager()

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
        alertManager.delegate = self
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
        
        let isFormValid = formController()
        
        if isFormValid {
            guard let username = usernameTextField.text, let password = passwordTextField.text else {
                return
            }
            
            authManager.login(with: username, with: password) { result in
                switch result {
                case .success(let token):
                    print(token)
                case.failure(let error):
                    DispatchQueue.main.async {
                        let alert = Alert(title: "Error", message: error.localizedDescription, firstButtonTitle: "OK", firstButtonStyle: UIAlertAction.Style.cancel, isSecondButtonActive: false, secondButtonTitle: "Cancel", secondButtonStyle: UIAlertAction.Style.default, secondButtonHandler: nil)
                        self.alertManager.show(alert: alert)
                    }

                }
            }
        }
        

    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginWithTestPressed(_ sender: Any) {
    }
    
    private func formController() -> Bool {
        var isFormValid = true
        
        isFormValid = ValidationHelper.validateField(usernameTextField, errorLabel: usernameErrorLabel) && isFormValid
        isFormValid = ValidationHelper.validateField(passwordTextField, errorLabel: passwordErrorLabel) && isFormValid
        
        return isFormValid ? true : false
    }
}

extension LoginViewController: AlertManagerDelegate {
    func presentAlert(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
