//
//  ProductManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 4.05.2023.
//

import Foundation

protocol GettingMultipleProductsDelegate {
    func didSuccessGettingMultipleProducts(products: [Product])
    func didFailGettingMultipleProducts(error: Error)
}

protocol GettingProductDetailDelegate {
    func didSuccessGettingProductDetail(product: Product)
    func didFailGettingProductDetail(error: Error)
}

protocol SortProductsDelegate {
    func didSuccessSortingProducts(sortedProducts: [Product])
}

protocol FilterProductsDelegate {
    func didSuccessFilteringProducts(filteredProducts: [Product])
}

class ProductManager {
    let baseUrl = "https://fakestoreapi.com/products"
    var products: [Product] = []
    var gettingMultipleProductsDelegate: GettingMultipleProductsDelegate?
    var gettingProductDetailDelegate: GettingProductDetailDelegate?
    var sortProductsDelegate: SortProductsDelegate?
    var filterProductsDelegate: FilterProductsDelegate?
    
    func getProducts(categoryName: String? = nil){
        var urlString = baseUrl
        
        if let categoryName = categoryName {
            let encodedCategoryName = categoryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            urlString += "/category/\(encodedCategoryName)"
        }
        
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            gettingMultipleProductsDelegate?.didFailGettingMultipleProducts(error: error)
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                self.gettingMultipleProductsDelegate?.didFailGettingMultipleProducts(error: error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data returned", code: 0, userInfo: nil)
                self.gettingMultipleProductsDelegate?.didFailGettingMultipleProducts(error: error)
                return
            }
            self.products = []
            
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode([ProductData].self, from: data)
                for product in products {
                    let newProduct = Product(id: product.id, title: product.title, price: product.price, description: product.description, category: product.category, imageURL: product.image, rate: product.rating.rate, reviews: product.rating.count)
                    self.products.append(newProduct)
                }
                self.gettingMultipleProductsDelegate?.didSuccessGettingMultipleProducts(products: self.products)
                
            } catch {
                self.gettingMultipleProductsDelegate?.didFailGettingMultipleProducts(error: error)
            }
        }
        task.resume()
    }
    
    func getProduct(id: Int) {
        let urlString = "\(baseUrl)/\(id)"
        
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            gettingProductDetailDelegate?.didFailGettingProductDetail(error: error)
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error {
                self.gettingProductDetailDelegate?.didFailGettingProductDetail(error: error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data returned", code: 0, userInfo: nil)
                self.gettingProductDetailDelegate?.didFailGettingProductDetail(error: error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let productData = try decoder.decode(ProductData.self, from: data)
                let product = Product(id: productData.id, title: productData.title, price: productData.price, description: productData.description, category: productData.category, imageURL: productData.image, rate: productData.rating.rate, reviews: productData.rating.count)
                
                self.gettingProductDetailDelegate?.didSuccessGettingProductDetail(product: product)
            } catch {
                self.gettingProductDetailDelegate?.didFailGettingProductDetail(error: error)
            }
            
        }
        task.resume()
    }
    
    func sortProducts(products: [Product], criteria: SortingCriteria) {
        
        var listedProducts = products
        
        switch criteria {
        case .priceAscending:
            listedProducts.sort { $0.price < $1.price }
        case .priceDescending:
            listedProducts.sort { $0.price > $1.price }
        case .rating:
            listedProducts.sort { $0.rate > $1.rate }
        case .reviews:
            listedProducts.sort { $0.reviews > $1.reviews }
        }
        sortProductsDelegate?.didSuccessSortingProducts(sortedProducts: listedProducts)
        
    }
    
    func filterProducts(criteria: FilterCriteria) {
        var filteredProducts = products
    
        if let minRating = criteria.minRating {
            filteredProducts = filteredProducts.filter { $0.rate >= minRating }
        }
        
        if let minPrice = criteria.minPrice {
            filteredProducts = filteredProducts.filter { $0.price >= minPrice }
        }
        
        filterProductsDelegate?.didSuccessFilteringProducts(filteredProducts: filteredProducts)
    }
}
