//
//  addContactView.swift
//  Contacts
//
//  Created by Nursat on 17.02.2021.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var gender: String = "male-image"
    @ObservedObject private var viewModel: ContactsViewModel
    
    init(viewModel: ContactsViewModel) {
        self.viewModel = viewModel
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
                
                Picker(selection: $gender, label: Text(""), content: {
                    Text("male").tag("male-image")
                    Text("female").tag("female-image")
                })
                .frame(width: UIScreen.main.bounds.width, height: 100.0)
                
                Spacer()
                
                Button(action: {
                    viewModel.addContact(name: self.name, phone: self.phone, gender: self.gender)
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
            }.navigationBarTitle("New Contact")
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        AddContactView(viewModel: ContactsViewModel())
    }
}
