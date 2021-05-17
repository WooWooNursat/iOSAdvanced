//
//  ProfileViewModel.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var firstName: String = UserService.shared.user?.firstName ??  ""
    @Published var lastName: String = UserService.shared.user?.lastName ??  ""
    var email: String = UserService.shared.user?.email ?? ""
    @Published var phone: String = UserService.shared.user?.phone ?? ""
    @Published var image: String = UserService.shared.user?.image ?? "default-avatar"
    @Published var isEditing: Bool = false
    
    func setUser() {
        if isEditing {
            isEditing = false
            guard var user = UserService.shared.user else { return }
            user.firstName = firstName
            user.lastName = lastName
            user.phone = phone
            user.image = image
            UserService.shared.changeUser(user: user)
        } else {
            isEditing = true
        }
    }
    
    func logout() {
        UserService.shared.logout()
    }
}
