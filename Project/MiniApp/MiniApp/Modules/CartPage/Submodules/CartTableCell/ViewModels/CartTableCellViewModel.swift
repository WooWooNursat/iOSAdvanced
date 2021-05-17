//
//  CartTableCellViewModel.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import Foundation

class CartTableCellViewModel: ObservableObject {
    @Published var product: Product
    
    init(product: Product){
        _product = .init(initialValue: product)
    }
    
    func getImage() -> String {
        let base_url = "http://192.168.251.43:8000"
        if product.image!.contains(base_url) {
            return product.image!
        } else {
            return base_url.appending(product.image!)
        }
    }
}
