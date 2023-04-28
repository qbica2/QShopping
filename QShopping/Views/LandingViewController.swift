//
//  ViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 26.04.2023.
//

import UIKit

class LandingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func authButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            performSegue(withIdentifier: K.segues.landingToLogin, sender: nil)
        } else if sender.tag == 1 {
            performSegue(withIdentifier: K.segues.landingToRegister, sender: nil)
        }
    }
    
    @IBAction func testerRegisterPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.segues.landingToTester, sender: nil)
    }
    
}

