//
//  Cart.swift
//  MiniApp
//
//  Created by Nursat on 13.05.2021.
//

import Foundation

struct Cart: Codable {
    private enum CodingKeys: String, CodingKey {
        case products
        case client
    }
    
    public var products: [Product]
    public var client: User
}
