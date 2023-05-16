//
//  CartViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 12.05.2023.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyBasketButton: UIBarButtonItem!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func emptyBasketButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func completeOrderButtonPressed(_ sender: UIButton) {
    }
    
    
}

extension ShoppingCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCell", for: indexPath)
        
        return cell
    }
    
}

extension ShoppingCartViewController: UITableViewDelegate {
    
}
