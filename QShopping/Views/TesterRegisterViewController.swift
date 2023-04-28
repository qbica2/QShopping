//
//  TesterRegisterViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 27.04.2023.
//

import UIKit

class TesterRegisterViewController: UITableViewController {

    var userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    override func viewWillAppear(_ animated: Bool) {
        userManager.getUsers { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userManager.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cells.testerCell, for: indexPath) as! UserCell
        let user = userManager.users[indexPath.row]
        cell.emailLabel.text = user.email
        cell.passwordLabel.text = user.password
        cell.userImage.image = UIImage(systemName: "person.circle")
        cell.usernameLabel.text = user.username
        cell.loginLabel.text = "Login as \(user.firstname)"
        return cell
    }

}
