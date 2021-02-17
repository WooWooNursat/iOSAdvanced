//
//  ContactsViewModel.swift
//  Contacts
//
//  Created by Nursat on 16.02.2021.
//

import Foundation

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = [
        Contact(name: "Nursat Saduakhassov", phone: "87777777777", image: "male-image")
    ]
    
    func removeContact(at indexSet: IndexSet) {
        contacts.remove(atOffsets: indexSet)
    }
    
    func removeContact(contactid: UUID) {
        contacts.removeAll(where: { $0.id == contactid })
    }
    
    func addContact(name: String, phone: String, gender: String) {
        contacts.append(Contact(name: name, phone: phone, image: gender))
    }
    
    func editContact(contact: Contact) {
        contacts[contacts.firstIndex(where: {$0.id == contact.id })!] = contact
    }
}
