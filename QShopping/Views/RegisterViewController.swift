//
//  RegisterViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 27.04.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstnameView: UIView!
    @IBOutlet weak var lastnameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var streetView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var zipcodeView: UIView!
    @IBOutlet weak var phoneView: UIView!
    
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var streetText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var zipcodeText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var firstnameError: UILabel!
    @IBOutlet weak var lastnameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var cityError: UILabel!
    @IBOutlet weak var streetError: UILabel!
    @IBOutlet weak var numberError: UILabel!
    @IBOutlet weak var zipcodeError: UILabel!
    @IBOutlet weak var phoneError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        for view in [firstnameView, lastnameView, emailView, usernameView, passwordView, cityView, streetView, numberView, zipcodeView, phoneView] {
            view?.layer.cornerRadius = 12
        }
        for x in [firstnameError, lastnameError, emailError, usernameError, passwordError, cityError, streetError, numberError, zipcodeError, phoneError] {
            x?.isHidden = true
        }
    }

    @IBAction func registerPressed(_ sender: UIButton) {
       let isValid = formController()
        
    }
    
    private func formController() -> Bool {
        var isFormValid = true
        
        isFormValid = ValidationHelper.validateField(firstnameText, errorLabel: firstnameError) && isFormValid
        isFormValid = ValidationHelper.validateField(lastnameText, errorLabel: lastnameError) && isFormValid
        isFormValid = ValidationHelper.validateField(emailText, errorLabel: emailError) && isFormValid
        isFormValid = ValidationHelper.validateField(usernameText, errorLabel: usernameError) && isFormValid
        isFormValid = ValidationHelper.validateField(passwordText, errorLabel: passwordError) && isFormValid
        isFormValid = ValidationHelper.validateField(cityText, errorLabel: cityError) && isFormValid
        isFormValid = ValidationHelper.validateField(streetText, errorLabel: streetError) && isFormValid
        isFormValid = ValidationHelper.validateField(numberText, errorLabel: numberError) && isFormValid
        isFormValid = ValidationHelper.validateField(zipcodeText, errorLabel: zipcodeError) && isFormValid
        isFormValid = ValidationHelper.validateField(phoneText, errorLabel: phoneError) && isFormValid
        
        return isFormValid ? true : false
    }

}
