//
//  MainView.swift
//  MiniApp
//
//  Created by Nursat on 09.05.2021.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    var body: some View {
        ZStack {
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
                        ZStack {
                            VStack {
                                if ProductService.shared.productType == .wear {
                                    Picker(selection: $viewModel.gender, label: Text("Picker")){
                                        Text("Мужчинам").tag(1)
                                        Text("Женщинам").tag(2)
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .padding(.horizontal, 16)
                                    .padding(.top, 4)
                                }
                                VStack(spacing: 16) {
                                    ForEach(viewModel.collections, id: \.self) { collection in
                                        RecommendationsCollectionView(viewModel: RecommendationsCollectionViewModel(collectionType: collection, viewContext: viewModel.viewContext, products: viewModel.products))
                                    }
                                }
                                .padding(.vertical, 16)
                            }
                            if !viewModel.searchText.isEmpty,
                               let products: [Product] = ProductService.shared.productType == .wear ?
                            ProductService.shared.wear.filter({ $0.name.lowercased().contains(viewModel.searchText) }) :
                                ProductService.shared.food.filter({ $0.name.lowercased().contains(viewModel.searchText) }),
                               !products.isEmpty {
                                List {
                                    ForEach(products, id: \.id) { product in
                                        NavigationLink(
                                            destination: ProductInfoView(viewModel: ProductInfoViewModel(product: product, viewContext: viewModel.viewContext, products: viewModel.products)),
                                            label: {
                                                VStack {
                                                    CartTableCellView(viewModel: CartTableCellViewModel(product: product))
                                                        .padding(.vertical, 26)
                                                }.foregroundColor(.black)
                                            })
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.bottom, 100)
                            }
                        }
                    }
                }
                .navigationBarTitle("Подборка", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    viewModel.showSideBar.toggle()
                }, label: {
                    Image("menu")
                }))
            }
            if viewModel.showSideBar {
                Color(.sRGB, red: 6/255, green: 35/255, blue: 67/255, opacity: 0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.linear(duration: 0.3))
                SideBarView(showSideBar: $viewModel.showSideBar)
                    .animation(.easeInOut(duration: 0.3))
                    .transition(.move(edge: .leading))
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
