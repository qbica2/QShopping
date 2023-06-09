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
    @IBOutlet weak var primaryButton: UIButton!
    
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
            self.updatePrimartButton()
        }
    }
    
    func updatePrimartButton(){
        if cartManager.products.isEmpty {
            primaryButton.setTitle("Select Product", for: .normal)
        } else {
            primaryButton.setTitle("Complete The Order", for: UIControl.State.normal)
        }
    }
    
    
    @IBAction func emptyBasketButtonPressed(_ sender: UIBarButtonItem) {
        let alert = Alert(title: K.Alert.warningTitle,
                          message: "Are you sure you want to empty your cart? This action cannot be undone.",
                          firstButtonTitle: K.Alert.cancelButtonTitle,
                          firstButtonStyle: .cancel,
                          isSecondButtonActive: true,
                          secondButtonTitle: K.Alert.yesButtonTitle,
                          secondButtonStyle: .destructive) {
            self.cartManager.clearCart()
        }
        self.alertManager.show(alert: alert)
    }
    
    @IBAction func primaryButtonPressed(_ sender: UIButton) {
        if cartManager.products.isEmpty {
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 0
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.segues.cartToDetail, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.cartToDetail {
            let destinationVC = segue.destination as! ProductDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                if let item = cartManager.item(at: indexPath.row) {
                    destinationVC.selectedProductID = item.product.id
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionhandler in
            if let itemToDelete = self.cartManager.item(at: indexPath.row) {
                self.cartManager.deleteItemFromCart(id: itemToDelete.product.id)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                completionhandler(true)
            }
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
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
            self.cartManager.changeQuantity(at: index, increment: false)
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
