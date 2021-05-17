//
//  Card.swift
//  MiniApp
//
//  Created by Nursat on 17.05.2021.
//

import Foundation

public class Card: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case number
        case expireDate = "expire_date"
        case balance
        case cvv
        case fullName = "full_name"
    }
    
    public var id: Int
    public var number: String?
    public var expireDate: Date?
    public var balance: Int
    public var cvv: String?
    public var fullName: String?
}

extension Card: Equatable {
    public static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
