//
//  FavoritesViewModel.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import Foundation
import CoreData
import SwiftUI

class FavoritesViewModel: ObservableObject {
    var viewContext: NSManagedObjectContext
    var products: [FetchedResults<FavProduct>.Element]
    @Published var searchText: String = ""
    
    init(viewContext: NSManagedObjectContext, products: [FetchedResults<FavProduct>.Element]) {
        self.viewContext = viewContext
        self.products = products
    }
    
    func getProductById(id: Int) -> Product {
        if let product = ProductService.shared.wear.first(where: { $0.id == id }) {
            return product
        }
        else { return ProductService.shared.food.first(where: { $0.id == id })! }
    }
}
