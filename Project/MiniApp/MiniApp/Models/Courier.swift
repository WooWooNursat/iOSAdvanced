//
//  Courier.swift
//  MiniApp
//
//  Created by Nursat on 16.05.2021.
//

import Foundation

public class Courier: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case phone
        case salary
        case review
    }
    
    public var id: Int
    public var email: String
    public var firstName: String?
    public var lastName: String?
    public var phone: String?
    public var salary: Int
    public var review: Int
}

extension Courier: Equatable {
    public static func == (lhs: Courier, rhs: Courier) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
