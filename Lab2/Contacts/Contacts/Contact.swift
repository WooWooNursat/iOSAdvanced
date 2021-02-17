//
//  Contact.swift
//  Contacts
//
//  Created by Nursat on 16.02.2021.
//

import Foundation

struct Contact: Identifiable {
    var name: String
    var phone: String
    var image: String
    var id = UUID()
}
