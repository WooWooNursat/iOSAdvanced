//
//  FavoritesCollectionCell.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import Foundation

class FavoritesCollectionCellViewModel: ObservableObject {
    @Published var product: FavProduct
    
    init(product: FavProduct) {
        _product = .init(initialValue: product)
    }
}
