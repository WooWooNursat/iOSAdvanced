//
//  ContactInfoView.swift
//  Contacts
//
//  Created by Nursat on 17.02.2021.
//

import SwiftUI

struct ContactInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    private var contactid: UUID
    private var viewModel: ContactsViewModel
    
    init(contactid: UUID, viewModel: ContactsViewModel) {
        self.contactid = contactid
        self.viewModel = viewModel
    }
    var body: some View {
        let contact = viewModel.contacts.first(where: { $0.id == contactid })
        VStack {
            ContactView(contact: contact != nil ? contact! : Contact(name: "", phone: "", image: ""), size: 1.5)
                .frame(width: UIScreen.main.bounds.width, height: 120)
            
            Spacer()
            
            Button(action: {}, label: {
                Text("Call")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .medium))
            })
            .padding(.vertical, 5)
            .background(Color.green)
            .padding(.horizontal, 20)
            NavigationLink(
                destination: EditContactView(contactid: contactid, viewModel: viewModel),
                label: {
                    Text("Edit")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium))
                })
                .padding(.vertical, 5)
                .background(Color.blue)
                .padding(.horizontal, 20)
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                viewModel.removeContact(contactid: contactid)
            }, label: {
                Text("Delete")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .medium))
            })
            .padding(.vertical, 5)
            .background(Color.red)
            .padding(.horizontal, 20)
        }
        .navigationBarTitle("Contact Info")
    }
}
//
//struct ContentView_Previews2: PreviewProvider {
//    static var previews: some View {
//        ContactInfoView(contact: Contact(name: "Nursat", phone: "87777777777", image: "male-image"), viewModel: ContactsViewModel())
//    }
//}
