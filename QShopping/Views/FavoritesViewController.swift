//
//  FavoritesViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 23.05.2023.
//

import UIKit
import Kingfisher

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var favoriteManager = FavoriteManager.shared
    var alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        alertManager.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: NSNotification.Name(K.NotificationName.favUpdated), object: nil)
    }
    
    @objc func update(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        let alert = Alert(title: K.Alert.warningTitle,
                          message: "Are you sure you want to delete all favorites? This action cannot be undone.",
                          firstButtonTitle: K.Alert.cancelButtonTitle,
                          firstButtonStyle: .cancel,
                          isSecondButtonActive: true,
                          secondButtonTitle: K.Alert.yesButtonTitle,
                          secondButtonStyle: .destructive) {
            self.favoriteManager.clearFavorites()
        }
        self.alertManager.show(alert: alert)
    }
    
    @IBAction func primaryButtonTapped(_ sender: UIButton) {
    }
}
//MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteManager.favoriteItemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cells.favoriteCell, for: indexPath) as! FavoriteCell
        
        if let item = favoriteManager.item(at: indexPath.row) {
            cell.priceLabel.text = "$ \(item.price)"
            cell.descriptionLabel.text = item.description
            cell.titleLabel.text = item.title
            
            let url = URL(string: item.imageURL)
            cell.itemImage.kf.setImage(with: url)
            
            cell.selectedProduct = item
            
        }
        
        return cell
    }
    
}
//MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionhandler in
            if let itemToDelete = self.favoriteManager.item(at: indexPath.row) {
                self.favoriteManager.removeFromFavorites(id: itemToDelete.id)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                completionhandler(true)
            }
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
//MARK: - AlertManagerDelegate

extension FavoritesViewController: AlertManagerDelegate {
    func presentAlert(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
