//
//  Order.swift
//  MiniApp
//
//  Created by Nursat on 16.05.2021.
//

import Foundation

public class Order: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case client
        case courier
        case products
        case isDelivered = "is_delivered"
    }
    
    public var id: Int
    public var client: User
    public var courier: Courier?
    public var products: [Product]
    public var isDelivered: Bool
}

extension Order: Equatable {
    public static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
