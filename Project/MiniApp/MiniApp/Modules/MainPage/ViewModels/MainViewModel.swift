//
//  MainViewModel.swift
//  MiniApp
//
//  Created by Nursat on 09.05.2021.
//

import Foundation
import CoreData
import SwiftUI

class MainViewModel: ObservableObject {
    var viewContext: NSManagedObjectContext
    var products: [FetchedResults<FavProduct>.Element]
    @Published var gender: Gender = Gender.man
    @Published var searchText: String = ""
    @Published var showSideBar: Bool = false
    @Published var collections: [CollectionType] = [
        .discounts, .new, .popular
    ]
    
    init(viewContext: NSManagedObjectContext, products: [FetchedResults<FavProduct>.Element]) {
        self.viewContext = viewContext
        self.products = products
    }
}
