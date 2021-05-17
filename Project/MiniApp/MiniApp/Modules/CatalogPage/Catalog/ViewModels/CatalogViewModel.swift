//
//  CatalogViewModel.swift
//  MiniApp
//
//  Created by Nursat on 10.05.2021.
//

import Foundation
import CoreData
import SwiftUI
import PromiseKit

class CatalogViewModel: ObservableObject {
    var viewContext: NSManagedObjectContext
    var products: [FetchedResults<FavProduct>.Element]
    @Published var showSideBar = false
    @Published var gender: Gender = Gender.man
    
//    @Published var categories: [ProductCategory] = [
//        ProductCategory.sport, ProductCategory.shoes, ProductCategory.classic,
//        ProductCategory.accessories, ProductCategory.outerwear, ProductCategory.summer
//    ]
    
    @Published var categories: [Category] = []
    
    init(viewContext: NSManagedObjectContext, products: [FetchedResults<FavProduct>.Element]) {
        self.viewContext = viewContext
        self.products = products
    }
    
    func getCategories() {
        firstly {
            ProductService.shared.getCategories()
        }.done { response in
            self.categories = response
        }.catch { error in
            print(error)
        }
    }
}
