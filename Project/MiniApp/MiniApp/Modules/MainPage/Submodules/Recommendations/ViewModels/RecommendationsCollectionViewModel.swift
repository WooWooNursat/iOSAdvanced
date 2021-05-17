//
//  RecommendationsCollectionViewModel.swift
//  MiniApp
//
//  Created by Nursat on 10.05.2021.
//

import Foundation
import CoreData
import SwiftUI

class RecommendationsCollectionViewModel: ObservableObject {
    var viewContext: NSManagedObjectContext
    var favProducts: [FetchedResults<FavProduct>.Element]
    var collectionType: CollectionType
    @Published var products: [Product] = ProductService.shared.productType == .wear ? ProductService.shared.wear : ProductService.shared.food
    
    init(collectionType: CollectionType, viewContext: NSManagedObjectContext, products: [FetchedResults<FavProduct>.Element]) {
        self.collectionType = collectionType
        self.viewContext = viewContext
        self.favProducts = products
    }
}
