//
//  CardView.swift
//  MiniApp
//
//  Created by Nursat on 17.05.2021.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel = CardViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Balance: \(viewModel.card?.balance ?? 0) тг")
                .font(.system(size: 20, weight: .medium))
            VStack(alignment: .leading, spacing: 16) {
                TextField("Введите номер карты", text: $viewModel.number)
                    .font(.system(size: 18, weight: .regular))
                
                
                TextField("Введите cvv", text: $viewModel.cvv)
                    .font(.system(size: 18, weight: .regular))
                TextField("Введите имя", text: $viewModel.fullName)
                    .font(.system(size: 18, weight: .regular))
                DatePicker("Expire date", selection: $viewModel.expireDate, displayedComponents: [.date])
            }
            Spacer()
        }
        .navigationBarItems(trailing: Button(action: {
            viewModel.setCard()
        }, label: {
            Text("Сохранить")
        }))
        .padding(.all, 16)
        .onAppear {
            viewModel.getCard()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
