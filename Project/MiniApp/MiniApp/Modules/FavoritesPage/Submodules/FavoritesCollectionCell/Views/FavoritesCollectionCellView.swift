//
//  FavoritesCollectionCellView.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import SwiftUI

struct FavoritesCollectionCellView: View {
    @ObservedObject var viewModel: FavoritesCollectionCellViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = viewModel.product.image {
                RemoteImage(url: image)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 148, height: 100, alignment: .center)
                    .cornerRadius(10)
                    .padding(.bottom, 8)
            } else {
                Image("default-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 148, height: 100, alignment: .center)
                    .cornerRadius(10)
                    .padding(.bottom, 8)
            }
            Text(viewModel.product.name ?? "Название товара")
                .font(.system(size: 14, weight: .semibold))
                .padding(.bottom, 2)
            Text("\(viewModel.product.price) тг")
                .font(.system(size: 14, weight: .regular))
        }
    }
}

//struct FavoritesCollectionCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesCollectionCellView(viewModel: FavoritesCollectionCellViewModel(product: Product(name: "Название товара", price: 9999, image: "default-image")))
//    }
//}
