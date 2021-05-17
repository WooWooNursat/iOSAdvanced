//
//  LoginViewModel.swift
//  MiniApp
//
//  Created by Nursat on 09.05.2021.
//

import Foundation
import PromiseKit

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isRegistration: Bool = false
    @Published var showAlert: Bool = false
    @Published var animate: Bool = false
    
    func login() {
        firstly {
            UserService.shared.login(email: email.lowercased(), password: password)
        }.done {
            
        }.catch { error in
            print(error)
        }.finally {
            self.showAlert = UserService.shared.token == nil
        }
    }
    
    func register() {
        firstly {
            UserService.shared.createUser(email: email.lowercased(), password: password)
        }.done { response in
            UserService.shared.login(email: self.email.lowercased(), password: self.password)
        }.catch { error in
            print(error)
        }
    }
}
