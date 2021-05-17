//
//  Token.swift
//  MiniApp
//
//  Created by Nursat on 16.05.2021.
//

import Foundation

struct Token: Codable {
    private enum CodingKeys: String, CodingKey {
        case token
    }
    
    public var token: String
}
