//
//  ProductService.swift
//  MiniApp
//
//  Created by Nursat on 12.05.2021.
//

import Foundation
import Alamofire
import PromiseKit

public enum ProductType: Int {
    case wear = 1
    case food = 2
}

class ProductService: ObservableObject {
    
    static let shared = ProductService()
    
    let base_url = "http://192.168.251.43:8000/"
    
    var productType: ProductType = .wear
    @Published var wear: [Wear] = []
    @Published var food: [Food] = []
    @Published var cartProducts: [Product] = []
    
    func getCategories() -> Promise<[Category]> {
        var request = URLRequest(url: URL(string: base_url.appending("main/categories/\(productType.rawValue)"))!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        return Promise { seal in
            AF.request(request).responseDecodable(of: [Category].self) { response in
                guard let categories = response.value else { return }
                seal.fulfill(categories)
            }
        }
    }
    
    func getWear() -> Promise<[Wear]> {
        var request = URLRequest(url: URL(string: base_url.appending("main/wear/"))!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        return Promise { seal in
            AF.request(request).responseDecodable(of: [Wear].self) { response in
                guard let wear = response.value else { return }
                seal.fulfill(wear)
            }
        }
    }
    
    func getFood() -> Promise<[Food]> {
        var request = URLRequest(url: URL(string: base_url.appending("main/food/"))!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        return Promise { seal in
            AF.request(request).responseDecodable(of: [Food].self) { response in
                guard let food = response.value else { return }
                seal.fulfill(food)
            }
        }
    }
    
    func updateProducts() {
        firstly {
            getWear()
        }.done { response in
            self.wear = response
        }.then {
            self.getFood()
        }.done { response in
            self.food = response
        }.catch { error in
            print(error)
        }
    }
    
    func getCartProducts() -> Promise<[Product]> {
        var request = URLRequest(url: URL(string: base_url.appending("main/cart/"))!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        return Promise { seal in
            AF.request(request).responseDecodable(of: Cart.self) { response in
                guard let cart = response.value else { return }
                self.cartProducts = cart.products
                seal.fulfill(cart.products)
            }
        }
    }
    
    func addToCart(product: Product) -> Promise<Void> {
        var request = URLRequest(url: URL(string: base_url.appending("main/cart/"))!)
        request.httpMethod = HTTPMethod.patch.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        let parameters = [
            "add": [product.id]
        ]
        do {
            request = try JSONEncoding.default.encode(request, with: parameters)
        } catch {
            print(error)
        }
        return Promise { seal in
            AF.request(request).responseJSON { response in
                guard let _ = response.value else { return }
                seal.fulfill(())
            }
        }
    }
    
    func removeFromCart(product: Product) -> Promise<Void> {
        var request = URLRequest(url: URL(string: base_url.appending("main/cart/"))!)
        request.httpMethod = HTTPMethod.patch.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        let parameters = [
            "remove": [product.id]
        ]
        do {
            request = try JSONEncoding.default.encode(request, with: parameters)
        } catch {
            print(error)
        }
        return Promise { seal in
            AF.request(request).responseJSON { response in
                guard let _ = response.value else { return }
                seal.fulfill(())
            }
        }
    }
    
    func changeProductType(type: ProductType) {
        self.productType = type
        updateProducts()
    }
    
    func order() -> Promise<Bool> {
        var request = URLRequest(url: URL(string: base_url.appending("main/orders/"))!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        return Promise { seal in
            AF.request(request).responseJSON { response in
                guard let data = response.value else { return }
                if data is [String: String] {
                    seal.fulfill(false)
                }
                seal.fulfill(true)
            }
        }
    }
    
    func getOrders() -> Promise<[Order]> {
        var request = URLRequest(url: URL(string: base_url.appending("main/orders/"))!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        return Promise { seal in
            AF.request(request).responseDecodable(of: [Order].self) { response in
                guard let orders = response.value else { return }
                seal.fulfill(orders)
            }
        }
    }
    
    func deleteOrder(id: Int) -> Promise<Void> {
        var request = URLRequest(url: URL(string: base_url.appending("main/orders/\(id)"))!)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        return Promise { seal in
            AF.request(request).responseJSON { response in
                guard let _ = response.value else { return }
                seal.fulfill(())
            }
        }
    }
}
