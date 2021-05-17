//
//  SideBarViewModel.swift
//  MiniApp
//
//  Created by Nursat on 10.05.2021.
//

import Foundation

struct SideBarItem {
    var id = UUID()
    var name: String;
    var image: String;
    var productType: ProductType;
}

class SideBarViewModel: ObservableObject {
    @Published var items: [SideBarItem] = [
        SideBarItem(name: "Одежда и обувь", image: "wear-icon", productType: .wear),
        SideBarItem(name: "Еда", image: "food-icon", productType: .food)
    ]
    
    func changeProductType(item: SideBarItem) {
        ProductService.shared.changeProductType(type: item.productType)
    }
}
