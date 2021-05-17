//
//  CardViewModel.swift
//  MiniApp
//
//  Created by Nursat on 17.05.2021.
//

import Foundation
import PromiseKit

class CardViewModel: ObservableObject {
    @Published var card: Card? = nil
    @Published var number: String = ""
    @Published var expireDate: Date = .distantFuture
    @Published var cvv: String = ""
    @Published var fullName: String = ""
    
    func getCard() {
        firstly {
            UserService.shared.getCard()
        }.done { response in
            self.card = response
            self.number = response.number ?? ""
            self.expireDate = response.expireDate ?? .distantFuture
            self.cvv = response.cvv ?? ""
            self.fullName = response.fullName ?? ""
        }.catch { error in
            print(error)
        }
    }
    
    func setCard() {
        guard let card = card else { return }
        card.number = self.number
        card.expireDate = self.expireDate
        card.cvv = self.cvv
        card.fullName = self.fullName
        UserService.shared.setCard(card: card)
    }
}
