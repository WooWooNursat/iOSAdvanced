//
//  UserService.swift
//  MiniApp
//
//  Created by Nursat on 13.05.2021.
//

import Foundation
import Alamofire
import PromiseKit

class UserService: ObservableObject {
    static let shared = UserService()
    
    @Published var user: User? = nil
    var token: String? = nil
    
    let base_url = "http://192.168.251.43:8000/"
    
    func getCard() -> Promise<Card> {
        var request = URLRequest(url: URL(string: base_url.appending("auth/card/"))!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        return Promise { seal in
            AF.request(request).responseDecodable(of: Card.self) { response in
                guard let card = response.value else { return }
                seal.fulfill(card)
            }
        }
    }
    
    func setCard(card: Card) -> Promise<Void> {
        var request = URLRequest(url: URL(string: base_url.appending("auth/card/"))!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        let date = card.expireDate ?? .distantFuture
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let parameters: [String: Any] = [
            "number": card.number,
            "expire_date": dateFormat.string(from: date),
            "balance": card.balance,
            "cvv": card.cvv,
            "full_name": card.fullName
        ].compactMapValues({$0})
        do {
            request = try JSONEncoding.default.encode(request, with: parameters)
        } catch {
            print(error)
        }
        return Promise { seal in
            AF.request(request).responseJSON { response in
                guard let _ = response.value else { return }
                seal.fulfill(())
            }
        }
    }
    
    func changeUser(user: User) -> Promise<Void> {
        var request = URLRequest(url: URL(string: base_url.appending("auth/clients/"))!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.timeoutInterval = 30
        if let token = UserService.shared.token {
            request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        }
        let parameters = [
            "first_name": user.firstName,
            "last_name": user.lastName,
            "phone": user.phone
        ]
        do {
            request = try JSONEncoding.default.encode(request, with: parameters)
        } catch {
            print(error)
        }
        return Promise { seal in
            AF.request(request).responseDecodable(of: User.self) { response in
                guard let user = response.value else { return }
                self.user = user
            }
            seal.fulfill(())
        }
    }
    
    func createUser(email: String, password: String) -> Promise<User> {
        var request = URLRequest(url: URL(string: base_url.appending("auth/clients/"))!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.timeoutInterval = 30
        let parameters = ["email": email, "password": password]
        do {
            request = try JSONEncoding.default.encode(request, with: parameters)
        } catch {
            print(error)
        }
        return Promise { seal in
            AF.request(request).responseDecodable(of: User.self) { response in
                guard let user = response.value else { return }
                seal.fulfill(user)
            }
        }
    }
    
    func login(email: String, password: String) -> Promise<Void> {
        var request = URLRequest(url: URL(string: "http://192.168.251.43:8000/auth/")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.timeoutInterval = 30
        let parameters = ["email": email, "password": password]
        do {
            request = try JSONEncoding.default.encode(request, with: parameters)
        } catch {
            print(error)
        }
        return Promise { seal in
            AF.request(request).responseDecodable(of: Token.self) { response in
                guard let token = response.value else { return }
                self.token = token.token
                self.getUser(token: token.token)
                seal.fulfill(())
            }
        }
    }
    
    func getUser(token: String) {
        var request = URLRequest(url: URL(string: "http://192.168.251.43:8000/auth/clients/")!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        request.headers.add(HTTPHeader(name: "Authorization", value: "JWT \(token)"))
        AF.request(request).responseDecodable(of: User.self) { response in
            guard let user = response.value else { return }
            self.user = user
        }
    }
    
    func logout() {
        user = nil
        token = nil
    }
}
