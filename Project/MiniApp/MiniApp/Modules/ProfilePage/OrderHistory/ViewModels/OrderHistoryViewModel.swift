//
//  OrderHistoryViewModel.swift
//  MiniApp
//
//  Created by Nursat on 13.05.2021.
//

import Foundation
import PromiseKit

class OrderHistoryViewModel: ObservableObject {
    @Published var orders: [Order] = []
    
    func getOrders() {
        firstly {
            ProductService.shared.getOrders()
        }.done { response in
            self.orders = response
        }.catch { error in
            print(error)
        }
    }
    
    func deleteOrder(id: Int) {
        firstly {
            ProductService.shared.deleteOrder(id: id)
        }.done { response in
            self.getOrders()
        }.catch { error in
            print(error)
        }
    }
}
