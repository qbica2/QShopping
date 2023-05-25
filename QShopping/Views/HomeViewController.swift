//
//  HomeViewController.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 2.05.2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var listedProducts: [Product] = []
    var searchResults: [Product] = []
    var searchQuery: String?
    var productManager = ProductManager()
    var categoryManager = CategoryManager()
    var alertManager = AlertManager()
    let stackView = UIStackView()
    let loadingView = LoadingIndicator.shared
    var favoriteManager = FavoriteManager.shared

    @IBOutlet weak var categoriesScrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.show(in: self.view)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        productManager.gettingMultipleProductsDelegate = self
        alertManager.delegate = self
        searchBar.delegate = self
        
        setupStackViewInScrollView()
        
        categoryManager.getCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.createCategoryButtons(categories: categories)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = self.alertManager.errorAlert(for: error)
                    self.alertManager.show(alert: alert)
                }
            }
        }
        productManager.getProducts()
        
        editSortButtonMenu()
        editFilterButtonMenu()
        NotificationCenter.default.addObserver(self, selector: #selector(handleProductAddedNotification), name: NSNotification.Name(K.NotificationName.cartUpdated), object: nil)

    }
    
    @objc func handleProductAddedNotification(){
        let alert = Alert(title: K.Alert.successTitle,
                          message: "Product Added to your Shopping Cart",
                          firstButtonTitle: "OK",
                          firstButtonStyle: UIAlertAction.Style.default,
                          isSecondButtonActive: false,
                          secondButtonTitle: "CANCEL",
                          secondButtonStyle: UIAlertAction.Style.cancel,
                          secondButtonHandler: nil)
        alertManager.show(alert: alert)
    }
    
    func editSortButtonMenu() {
        
        let dollarImage = UIImage(systemName: "dollarsign.circle")
        let upArrowImage = UIImage(systemName: "arrow.up")
        let downArrowImage = UIImage(systemName: "arrow.down")
        let starImage = UIImage(systemName: "star.fill")
        let reviewImage = UIImage(systemName: "text.bubble")

        let sortByPriceLowToHigh = UIAction(title: "Price: Low to High", image: upArrowImage) { _ in
            self.productManager.sortProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: .priceAscending)
        }
        let sortByPriceHighToLow = UIAction(title: "Price: High to Low", image: downArrowImage) { _ in
            self.productManager.sortProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: .priceDescending)
        }
        let sortByRating = UIAction(title: "Most Rated", image: starImage) { _ in
            self.productManager.sortProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: .rating)
        }
        
        let sortByReviews = UIAction(title: "Most Reviewed", image: reviewImage) { _ in
            self.productManager.sortProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: .reviews)
        }
        
        let priceMenu = UIMenu(title: "Sort By Price",image: dollarImage, children: [sortByPriceLowToHigh,sortByPriceHighToLow])
        let menu = UIMenu(title: "Sort Options", children: [priceMenu,sortByRating,sortByReviews])
        
        sortButton.contentMode = .center
        sortButton.menu = menu
        sortButton.showsMenuAsPrimaryAction = true
        
    }
    
    func editFilterButtonMenu(){
        
        let starImage = UIImage(systemName: "star.fill")
        let dolarImage = UIImage(systemName: "dollarsign.circle")
        
        let filterFourStars = UIAction(title: "4+", image: starImage ) { _ in
            let filterCriteria = FilterCriteria(minRating: 4)
            self.productManager.filterProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: filterCriteria)
        }
        
        let filterThreeStars = UIAction(title: "3+", image: starImage ) { _ in
            let filterCriteria = FilterCriteria(minRating: 3)
            self.productManager.filterProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: filterCriteria)
        }
        
        let filterTwoStars = UIAction(title: "2+", image: starImage ) { _ in
            let filterCriteria = FilterCriteria(minRating: 2)
            self.productManager.filterProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: filterCriteria)
        }
        
        let filterByPrice1000 = UIAction(title: "1000+", image: dolarImage) { _ in
            let filterCriteria = FilterCriteria(minPrice: 1000)
            self.productManager.filterProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: filterCriteria)
        }
        
        let filterByPrice500 = UIAction(title: "500+", image: dolarImage) { _ in
            let filterCriteria = FilterCriteria(minPrice: 500)
            self.productManager.filterProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: filterCriteria)
        }
        
        let filterByPrice100 = UIAction(title: "100+", image: dolarImage) { _ in
            let filterCriteria = FilterCriteria(minPrice: 100)
            self.productManager.filterProducts(products: self.searchQuery != nil ? self.searchResults : self.listedProducts, criteria: filterCriteria)
        }
        
        let rateMenu = UIMenu(title: "Filter by Rate", image: starImage, children: [filterFourStars, filterThreeStars, filterTwoStars])
        
        let priceMenu = UIMenu(title: "Filter by Price", image: dolarImage, children: [filterByPrice1000, filterByPrice500, filterByPrice100])
        
        let filterMenu = UIMenu(title: "Filter Options", children: [rateMenu, priceMenu])
        
        filterButton.contentMode = .center
        filterButton.menu = filterMenu
        filterButton.showsMenuAsPrimaryAction = true

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
    
    @IBAction func resetFilterPressed(_ sender: UIButton) {
        searchQuery = nil
        listedProducts = productManager.products
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            let topOffset = CGPoint(x: 0, y: -self.collectionView.contentInset.top)
            self.collectionView.setContentOffset(topOffset, animated: true)
        }
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
        return searchQuery != nil ? searchResults.count : listedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cells.productCell, for: indexPath) as! ProductCell
        let product = searchQuery != nil ? searchResults[indexPath.row] : listedProducts[indexPath.row]
        let url = URL(string: product.imageURL)
        cell.imageView.kf.setImage(with: url)
        cell.titleLabel.text = product.title
        cell.priceLabel.text = "$\(product.price)"
        cell.rateLabel.text = String(product.rate)
        cell.reviewLabel.text = "\(product.reviews) reviews"
        cell.selectedProduct = product
        
        let isProductInFavorite = favoriteManager.isProductIDInFavorites(product.id)
        
        let favImage = isProductInFavorite ? "heart.fill" : "heart"
        cell.favoriteButton.setImage(UIImage(systemName: favImage), for: .normal)
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.segues.homeToDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.homeToDetail {
            let destinationVC = segue.destination as! ProductDetailViewController
            if let indexPath = collectionView.indexPathsForSelectedItems?.first{
                let product = searchQuery != nil ? searchResults[indexPath.row] : listedProducts[indexPath.row]
                destinationVC.selectedProductID = product.id
            }
        }
    }
}

//MARK: - GettingMultipleProductsDelegate

extension HomeViewController: GettingMultipleProductsDelegate {
    func didSuccessGettingMultipleProducts(products: [Product]) {
        if searchQuery != nil {
            searchResults = products
        } else {
            listedProducts = products
        }
        DispatchQueue.main.async {
            self.loadingView.dismiss()
            self.collectionView.reloadData()
            let topOffset = CGPoint(x: 0, y: -self.collectionView.contentInset.top)
            self.collectionView.setContentOffset(topOffset, animated: true)
        }
    }
    
    func didFailGettingMultipleProducts(error: Error) {
        DispatchQueue.main.async {
            let alert = self.alertManager.errorAlert(for: error)
            self.alertManager.show(alert: alert)
        }
    }
    
    func didReturnEmptyResult() {
        let alert = Alert(title: "Product Not Found", message: "No products found for your search. Please try a different keyword.", firstButtonTitle: "OK", firstButtonStyle: .default, isSecondButtonActive: false, secondButtonTitle: "CANCEL", secondButtonStyle: .cancel, secondButtonHandler: nil)
        alertManager.show(alert: alert)
    }
    
}

//MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        productManager.searchProducts(for: searchQuery!, products: listedProducts)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchQuery = nil
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            let topOffset = CGPoint(x: 0, y: -self.collectionView.contentInset.top)
            self.collectionView.setContentOffset(topOffset, animated: true)
        }
        searchBar.resignFirstResponder()
    }
}
