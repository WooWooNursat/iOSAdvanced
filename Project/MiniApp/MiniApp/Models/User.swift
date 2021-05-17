//
//  User.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import Foundation

public struct User: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phone
        case address
    }
    
    public var id: Int
    public var firstName: String?
    public var lastName: String?
    public var email: String
    public var phone: String?
    public var address: String?
    public var image = "default-avatar"
//    var password: String = "Undefined";
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
