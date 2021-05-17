//
//  CatalogView.swift
//  MiniApp
//
//  Created by Nursat on 10.05.2021.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject var viewModel: CatalogViewModel
    @ObservedObject var productService = ProductService.shared
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        if ProductService.shared.productType == .wear {
                            Picker(selection: $viewModel.gender, label: Text("Picker")){
                                Text("Мужчинам").tag(1)
                                Text("Женщинам").tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                        }
                        ForEach(viewModel.categories, id: \.id) { category in
                            NavigationLink(
                                destination: ProductListView(viewModel: ProductListViewModel(category: category, viewContext: viewModel.viewContext, products: viewModel.products)),
                                label: {
                                    CatalogTableCellView(category: category)
                                        .foregroundColor(.black)
                                })
                        }
                        .padding(.top, ProductService.shared.productType == .wear ? 0 : 16)
                    }
                }
                .navigationBarTitle("Каталог", displayMode: .inline)
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
        .onAppear {
            viewModel.getCategories()
        }
        .onReceive(productService.$food, perform: { _ in
            viewModel.getCategories()
        })
    }
}

//struct CatalogView_Previews: PreviewProvider {
//    static var previews: some View {
//        CatalogView()
//    }
//}
