//
//  HomeViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 2.05.2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var productManager = ProductManager()
    var categoryManager = CategoryManager()
    var alertManager = AlertManager()
    
    @IBOutlet weak var categoriesScrollView: UIScrollView!
    let stackView = UIStackView()
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        productManager.gettingMultipleProductsDelegate = self
        alertManager.delegate = self
        
        setupStackViewInScrollView()
        
        categoryManager.getCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.createCategoryButtons(categories: categories)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = Alert(title: "Error", message: error.localizedDescription, firstButtonTitle: "OK", firstButtonStyle: UIAlertAction.Style.default, isSecondButtonActive: false, secondButtonTitle: "CANCEL", secondButtonStyle: UIAlertAction.Style.cancel, secondButtonHandler: nil)
                    self.alertManager.show(alert: alert)
                }
            }
        }
        productManager.getProducts()
    }
    
    func setupStackViewInScrollView() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        categoriesScrollView.translatesAutoresizingMaskIntoConstraints = false
        categoriesScrollView.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        
        stackView.leadingAnchor.constraint(equalTo: categoriesScrollView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: categoriesScrollView.trailingAnchor, constant: -10).isActive = true
        stackView.centerYAnchor.constraint(equalTo: categoriesScrollView.centerYAnchor).isActive = true
    }
    
    func createCategoryButtons(categories: [String]) {
        
        let allButton = createButton(title: "All")
        allButton.isSelected = true
        stackView.addArrangedSubview(allButton)
        
        for category in categories {
            let button = createButton(title: category)
            stackView.addArrangedSubview(button)
        }
    }
    
    func createButton(title: String) -> UIButton {
        var config = UIButton.Configuration.gray()
        config.title = title
        config.buttonSize = .small
        config.cornerStyle = .small
        config.baseForegroundColor = .label
        
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        return button
        
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        
        for case let button as UIButton in stackView.arrangedSubviews where button != sender {
            button.isSelected = false
        }
        
        sender.isSelected = !sender.isSelected
        
        if let title = sender.titleLabel?.text {
            if title == "All" {
                productManager.getProducts()
            } else {
                productManager.getProducts(categoryName:title)
            }
        }
    }

    
}
//MARK: - AlertManager Delegate

extension HomeViewController: AlertManagerDelegate {
    func presentAlert(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productManager.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        let product = productManager.products[indexPath.row]
        let url = URL(string: product.imageURL)
        cell.imageView.kf.setImage(with: url)
        cell.titleLabel.text = product.title
        cell.priceLabel.text = "$\(product.price)"
        cell.rateLabel.text = String(product.rate)
        cell.reviewLabel.text = "\(product.reviews) reviews"
        
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10 ) / 2
        return CGSize(width: size, height: 400)
    }
}
//MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    //Bu extension boş bırakılabilir.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = productManager.products[indexPath.row]
        print(item)
    }
}
//MARK: - GettingMultipleProductsDelegate

extension HomeViewController: GettingMultipleProductsDelegate {
    func didSuccessGettingMultipleProducts() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            let topOffset = CGPoint(x: 0, y: -self.collectionView.contentInset.top)
            self.collectionView.setContentOffset(topOffset, animated: true)
        }
    }
    
    func didFailGettingMultipleProducts(error: Error) {
        DispatchQueue.main.async {
            let alert = Alert(title: "Error", message: error.localizedDescription, firstButtonTitle: "OK", firstButtonStyle: UIAlertAction.Style.default, isSecondButtonActive: false, secondButtonTitle: "CANCEL", secondButtonStyle: UIAlertAction.Style.cancel, secondButtonHandler: nil)
            self.alertManager.show(alert: alert)
        }
    }
    
}

