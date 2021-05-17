//
//  ProductInfoView.swift
//  MiniApp
//
//  Created by Nursat on 12.05.2021.
//

import SwiftUI

struct ProductInfoView: View {
    @ObservedObject var viewModel: ProductInfoViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let image = viewModel.product.image {
                RemoteImage(url: viewModel.getImage())
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                    .background(Color.black)
            } else {
                Image("default-image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                    .background(Color.black)
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(viewModel.product.name)
                        .font(.system(size:20, weight: .semibold))
                    Text("Категория №\(viewModel.product.category ?? 0)")
                }
                Spacer()
                if !viewModel.toFavorites {
                    Button(action: {
                        viewModel.addtoFav()
                    }, label: {
                        Image(systemName: "heart")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(.red)
                            .padding(.trailing, 8)
                    })
                } else {
                    Button(action: {
                        viewModel.removeFromFav()
                    }, label: {
                        Image(systemName: "heart.fill")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(.red)
                            .padding(.trailing, 8)
                    })
                }
                Button(action: {
                    guard !viewModel.isAdded else { return }
                    viewModel.addToCart()
                }, label: {
                    Text(!viewModel.isAdded ? "В корзину" : "Добавлен")
                        .foregroundColor(!viewModel.isAdded ? .main : .white)
                        .padding(.all, 4)
                })
                .background(viewModel.isAdded ? Color.main : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.main, lineWidth: 1)
                )
            }
            .padding(.horizontal, 16)
            Text("\(viewModel.product.price) тг")
                .padding(.horizontal, 16)
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Описание")
                    .font(.system(size:20, weight: .semibold))
                Text(viewModel.product.description ?? "")
            }
            .padding(.horizontal, 16)
            Spacer()
        }
    }
}

//struct ProductInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductInfoView()
//    }
//}
