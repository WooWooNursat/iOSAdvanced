//
//  ProductListViewModel.swift
//  MiniApp
//
//  Created by Nursat on 12.05.2021.
//

import Foundation
import CoreData
import SwiftUI
import PromiseKit

class ProductListViewModel: ObservableObject {
    var viewContext: NSManagedObjectContext
    var favProducts: [FetchedResults<FavProduct>.Element]
    @Published var products: [Product]
    @Published var productCategory: Category
    @Published var searchText: String = ""
    
    init(category: Category, filter: String = "", viewContext: NSManagedObjectContext, products: [FetchedResults<FavProduct>.Element]) {
        _productCategory = .init(initialValue: category)
        self.products = ProductService.shared.productType == .wear ? ProductService.shared.wear.filter({ $0.category == category.id }) : ProductService.shared.food.filter({ $0.category == category.id })
        self.viewContext = viewContext
        self.favProducts = products
        if filter != "" {
            self.products = ProductService.shared.productType == .wear ?
                self.products.filter( { $0.name.contains(filter) }) :
                self.products.filter( { $0.name.contains(filter) })
        }
    }
}
