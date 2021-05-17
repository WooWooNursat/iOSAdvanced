//
//  ProductInfoViewModel.swift
//  MiniApp
//
//  Created by Nursat on 12.05.2021.
//

import Foundation
import CoreData
import SwiftUI

class ProductInfoViewModel: ObservableObject {
    @Published var product: Product
    @Published var isAdded: Bool = false
    @Published var toFavorites: Bool = false
    var viewContext: NSManagedObjectContext
    var favProducts: [FetchedResults<FavProduct>.Element]
    init(product: Product, viewContext: NSManagedObjectContext, products: [FetchedResults<FavProduct>.Element]) {
        _product = .init(initialValue: product)
        self.viewContext = viewContext
        self.favProducts = products
        
        if ProductService.shared.cartProducts.contains(where: { $0.id == product.id }) {
            isAdded = true
        }
        
        if favProducts.contains(where: { $0.id == product.id }) {
            toFavorites = true
        }
    }
    
    func getImage() -> String {
        let base_url = "http://192.168.251.43:8000"
        if product.image!.contains(base_url) {
            return product.image!
        } else {
            return base_url.appending(product.image!)
        }
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        }
        catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
    func addtoFav() {
        self.toFavorites = true
        let product = FavProduct(context: viewContext)
        product.id = Int32(self.product.id)
        product.userId = Int32(UserService.shared.user!.id)
        product.name = self.product.name
        product.price = Int32(self.product.price)
        product.image = self.product.image
        saveContext()
    }
    
    func removeFromFav() {
        guard let fav = favProducts.first(where: { $0.id == product.id }) else { return }
        self.toFavorites = false
        viewContext.delete(fav)
        saveContext()
    }
    
    func addToCart() {
        ProductService.shared.addToCart(product: product)
        isAdded = true
    }
}
