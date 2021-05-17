//
//  CartTableCellView.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import SwiftUI

struct CartTableCellView: View {
    @ObservedObject var viewModel: CartTableCellViewModel
    var body: some View {
        HStack {
            if viewModel.product.image != nil {
                RemoteImage(url: viewModel.getImage())
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 136, height: 80, alignment: .center)
                    .cornerRadius(10)
            } else {
                Image("default-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 136, height: 80, alignment: .center)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(viewModel.product.name)
                    .font(.system(size: 14, weight: .medium))
                Text("\(viewModel.product.price) ₸")
                    .font(.system(size: 14, weight: .medium))
                    .padding(.top, 20)
                    .foregroundColor(Color(red: 131/255, green: 145/255, blue: 161/255))
            }
            .padding(.leading, 16)
            Spacer()
        }
        .frame(width: 344, height: 80, alignment: .center)
    }
}

//struct CartTableCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartTableCellView(viewModel: CartTableCellViewModel(product: Product(name: "Название товара", price: 9999, image: "default-image")))
//    }
//}
