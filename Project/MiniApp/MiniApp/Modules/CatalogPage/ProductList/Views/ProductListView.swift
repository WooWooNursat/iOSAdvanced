//
//  ProductListView.swift
//  MiniApp
//
//  Created by Nursat on 12.05.2021.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: ProductListViewModel
    var body: some View {
//        NavigationView {
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
                    
                    ForEach(viewModel.products.filter( {
                        !viewModel.searchText.isEmpty ?
                            ProductService.shared.productType == .wear ?
                            $0.name.lowercased().contains(viewModel.searchText) :
                            $0.name.lowercased().contains(viewModel.searchText)
                        : true
                                }), id: \.id) { product in
                        NavigationLink(
                            destination: ProductInfoView(viewModel: ProductInfoViewModel(product: product, viewContext: viewModel.viewContext, products: viewModel.favProducts)),
                            label: {
                                VStack {
                                    CartTableCellView(viewModel: CartTableCellViewModel(product: product))
                                        .padding(.vertical, 26)
                                    Rectangle()
                                        .frame(width: 343, height: 1, alignment: .center)
                                        .foregroundColor(Color(red: 232/255, green: 236/255, blue: 240/255))
                                }.foregroundColor(.black)
                            })
                    }
                }
            }
            .navigationBarTitle(viewModel.productCategory.name, displayMode: .inline)
//        }
    }
}

//struct ProductListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductListView()
//    }
//}
