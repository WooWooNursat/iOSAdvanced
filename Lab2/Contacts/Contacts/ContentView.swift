//
//  ContentView.swift
//  Contacts
//
//  Created by Nursat on 16.02.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContactsViewModel()
    
    var body: some View {
        NavigationView{
            switch !viewModel.contacts.isEmpty {
            case true:
                List {
                    ForEach(viewModel.contacts) { contact in
                        ZStack {
                            NavigationLink(destination: ContactInfoView(contactid: contact.id, viewModel: viewModel)) {
                                EmptyView()
                            }
                            .hidden()
                            ContactView(contact: contact)
                        }
                    }
                    .onDelete(perform: removeContact)
                }
                .toolbar(content: {
                    NavigationLink(destination: AddContactView(viewModel: viewModel)) {
                        Image(systemName: "plus").renderingMode(.original)
                    }
                })
                .navigationBarTitle("Contacts", displayMode: .inline)
                
            case false:
                VStack {
                    Text("No contacts")
                        .padding()
                    Spacer()
                }
                .toolbar(content: {
                    NavigationLink(destination: AddContactView(viewModel: viewModel)) {
                        Image(systemName: "plus").renderingMode(.original)
                    }
                })
                .navigationBarTitle("Contacts", displayMode: .inline)
            }
        }
    }
    
    private func removeContact(at indexSet: IndexSet) {
        viewModel.removeContact(at: indexSet)
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
