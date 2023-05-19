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
    
    let cartManager = CartManager.shared
    var alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        alertManager.delegate = self
        cartManager.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(K.NotificationName.cartUpdated), object: nil)
        updateUI()
    }
    
   @objc func updateUI(){
        let totalItem = cartManager.cartItemCount
        let totalPrice = cartManager.totalCartPrice()
        let formattedPrice = String(format: "%.2f", totalPrice)

        DispatchQueue.main.async {
            self.totalItemsLabel.text = "(\(totalItem))"
            self.totalPrice.text = "$\(formattedPrice)"
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func emptyBasketButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func completeOrderButtonPressed(_ sender: UIButton) {
    }
    
    
}
//MARK: - UITableViewDataSource

extension ShoppingCartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartManager.cartItemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cells.shoppingCartCell, for: indexPath) as! ShoppingCartCell
        
        if let item = cartManager.item(at: indexPath.row) {
            
            cell.priceLabel.text = "$ \(item.product.price)"
            cell.titleLabel.text = item.product.title
            cell.descriptionLabel.text = item.product.description
            cell.quantityLabel.text = String(item.quantity)
            cell.productQuantity = item.quantity
            let url = URL(string: item.product.imageURL)
            cell.itemImage.kf.setImage(with: url)
            
            cell.index = indexPath.row
            cell.delegate = self
        }
        return cell
    }
    
}
//MARK: - UITableViewDelegate

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
//MARK: - ShoppingCartCellDelegate

extension ShoppingCartViewController: ShoppingCartCellDelegate {
    func deleteButtonTapped(at index: Int) {
        let alert = Alert(title: K.Alert.warningTitle,
                          message: "Are you sure you want to remove this product from your cart?",
                          firstButtonTitle: K.Alert.cancelButtonTitle,
                          firstButtonStyle: .cancel,
                          isSecondButtonActive: true,
                          secondButtonTitle: K.Alert.yesButtonTitle,
                          secondButtonStyle: .destructive) {
            CartManager.shared.changeQuantity(at: index, increment: false)
        }
        self.alertManager.show(alert: alert)
    }
    
}
//MARK: - AlertManagerDelegate

extension ShoppingCartViewController: AlertManagerDelegate {
    func presentAlert(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
//MARK: - CartManagerDelegate

extension ShoppingCartViewController: CartManagerDelegate {
    func didCartChange() {
        updateUI()
    }
}
