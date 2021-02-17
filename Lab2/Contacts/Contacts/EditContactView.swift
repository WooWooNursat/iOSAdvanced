//
//  EditContactView.swift
//  Contacts
//
//  Created by Nursat on 17.02.2021.
//

import SwiftUI

struct EditContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: ContactsViewModel
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var image: String = "male-image"
    private var id: UUID!
    
    init(contactid: UUID, viewModel: ContactsViewModel) {
        self.viewModel = viewModel
        guard let contact = viewModel.contacts.first(where: { contactid == $0.id })
        else { return }
        _name = State(initialValue: contact.name)
        _phone = State(initialValue: contact.phone)
        _image = State(initialValue: contact.image)
        self.id = contactid
    }
    var body: some View {
        VStack {
            TextField("Enter name and surname", text: $name)
                .padding(10)
                .border(Color.gray, width: 0.5)
                .cornerRadius(6)
                .padding(20)
            
            TextField("Enter phone number", text: $phone)
                .padding(10)
                .border(Color.gray, width: 0.5)
                .cornerRadius(6)
                .padding(20)
            
            Picker(selection: $image, label: Text(""), content: {
                Text("male").tag("male-image")
                Text("female").tag("female-image")
            })
            .frame(width: UIScreen.main.bounds.width, height: 100.0)
            
            Spacer()
            
            Button(action: {
                viewModel.editContact(contact: Contact(name: self.name, phone: self.phone, image: self.image, id: self.id))
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .medium))
            })
            .padding(.vertical, 5)
            .background(Color.blue)
            .padding(.horizontal, 20)
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .medium))
            })
            .padding(.vertical, 5)
            .background(Color.red)
            .padding(.horizontal, 20)
        }.navigationBarTitle("Edit Contact")
    }
}
//
//struct EditContactView_Previews3: PreviewProvider {
//    static var previews: some View {
//        EditContactView(contact: Contact(name: "Nursat", phone: "87777777777", image: "female-image"), viewModel: ContactsViewModel())
//    }
//}
