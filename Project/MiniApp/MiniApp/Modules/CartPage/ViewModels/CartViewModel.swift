//
//  CartTableCellViewModel.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import Foundation
import CoreData
import SwiftUI
import PromiseKit

class CartViewModel: ObservableObject {
    var viewContext: NSManagedObjectContext
    var favProducts: [FetchedResults<FavProduct>.Element]
    @Published var noBalance = false
    @Published var products: [Product] = []
    
    init(viewContext: NSManagedObjectContext, products: [FetchedResults<FavProduct>.Element]) {
        self.viewContext = viewContext
        self.favProducts = products
    }
    
    func getTotal() -> Int {
        products.reduce(into: 0) { total, product in
            total += product.price
        }
    }
    
    func removeFromCart(product: Product) {
        ProductService.shared.removeFromCart(product: product)
        updateList()
    }
    
    func order() {
        firstly {
            ProductService.shared.order()
        }.done { response in
            self.noBalance = !response
            if response {
                self.updateList()
            }
        }.catch { error in
            print(error)
        }
    }
    
    func updateList() {
        firstly {
            ProductService.shared.getCartProducts()
        }.done { response in
            self.products = response
        }.catch { error in
            print(error)
        }
    }
}
