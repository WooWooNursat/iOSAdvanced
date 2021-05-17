//
//  FavoritesView.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel;
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Image("search-icon")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            .scaledToFit()
                            .padding(.leading, 4)
                        TextField("Найти товар", text: $viewModel.searchText)
                    }
                    .frame(width: 343, height: 32, alignment: .center)
                    .background(Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.05))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(viewModel.products.filter( {
                            !viewModel.searchText.isEmpty ?
                                $0.name!.lowercased().contains(viewModel.searchText) : true
                        }), id: \.id) { product in
                            NavigationLink(
                                destination: ProductInfoView(viewModel: ProductInfoViewModel(product: viewModel.getProductById(id: Int(product.id)), viewContext: viewModel.viewContext, products: viewModel.products)),
                                label: {
                                    FavoritesCollectionCellView(viewModel: FavoritesCollectionCellViewModel(product: product))
                                        .foregroundColor(.black)
                                })
                        }
                    }.padding(.top, 16)
                }
            }
            .navigationBarTitle("Избранное", displayMode: .inline)
        }
    }
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView()
//    }
//}
