//
//  Category.swift
//  MiniApp
//
//  Created by Nursat on 16.05.2021.
//

import Foundation

public struct Category: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public var id: Int
    public var name: String
}

extension Category: Equatable {
    public static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
}
