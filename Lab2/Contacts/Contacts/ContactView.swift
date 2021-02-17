//
//  ContactView.swift
//  Contacts
//
//  Created by Nursat on 17.02.2021.
//

import SwiftUI

struct ContactView: View {
    private let contact: Contact
    private let size: Double
    
    init(contact: Contact, size: Double = 1) {
        self.contact = contact
        self.size = size
    }
    var body: some View {
        HStack {
            Image(contact.image)
                .resizable()
                .frame(width: 80 * CGFloat(self.size), height: 80 * CGFloat(self.size))
            Spacer()
            VStack(spacing: 5) {
                Text(contact.name)
                    .font(.system(size: CGFloat(24 * self.size), weight: .medium))
                Text(contact.phone)
                    .font(.system(size: CGFloat(15 * self.size)))
            }
            Spacer()
        }
    }
}

