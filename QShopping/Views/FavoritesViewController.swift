//
//  FavoritesViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 23.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func primaryButtonTapped(_ sender: UIButton) {
    }
}
