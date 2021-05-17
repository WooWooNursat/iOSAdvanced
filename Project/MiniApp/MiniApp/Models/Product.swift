//
//  Product.swift
//  MiniApp
//
//  Created by Nursat on 10.05.2021.
//

import Foundation

public class Product: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case image
        case description
        case category
    }
    public var id: Int
    public var name: String
    public var price: Int
    public var image: String?
    public var description: String?
    public var category: Int?
}

public class Wear: Product {
    private enum CodingKeys: String, CodingKey {
        case size
        case materials
    }
    public var size: String
    public var materials: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        size = try container.decode(String.self, forKey: .size)
        materials = try container.decode(String.self, forKey: .materials)
        try super.init(from: decoder)
    }
}

extension Wear: Equatable {
    public static func == (lhs: Wear, rhs: Wear) -> Bool {
        return lhs.id == rhs.id
    }
}

public class Food: Product {
    private enum CodingKeys: String, CodingKey {
        case ingredients
    }
    
    public var ingredients: String?
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ingredients = try container.decode(String.self, forKey: .ingredients)
        try super.init(from: decoder)
    }
}

extension Food: Equatable {
    public static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.id == rhs.id
    }
}
