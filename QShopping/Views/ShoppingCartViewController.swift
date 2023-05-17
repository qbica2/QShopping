//
//  CartViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 12.05.2023.
//

import UIKit
import Kingfisher

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyBasketButton: UIBarButtonItem!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
//        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: NSNotification.Name("CartUpdated"), object: nil)

    }
    
//    @objc func cartUpdated(){
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
    
    
    @IBAction func emptyBasketButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func completeOrderButtonPressed(_ sender: UIButton) {
    }
    
    
}
//MARK: - UITableViewDataSource

extension ShoppingCartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cells.shoppingCartCell, for: indexPath) as! ShoppingCartCell
        
        let item = CartManager.shared.products[indexPath.row]
        cell.priceLabel.text = "$ \(item.product.price)"
        cell.titleLabel.text = item.product.title
        cell.descriptionLabel.text = item.product.description
        cell.quantityLabel.text = String(item.quantity)
        
        let url = URL(string: item.product.imageURL)
        cell.itemImage.kf.setImage(with: url)
        
        return cell
    }
    
}
//MARK: - UITableViewDelegate

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
