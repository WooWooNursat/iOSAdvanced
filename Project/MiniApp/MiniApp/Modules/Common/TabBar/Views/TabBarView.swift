//
//  TabBarView.swift
//  MiniApp
//
//  Created by Nursat on 09.05.2021.
//

import SwiftUI
import CoreData

struct TabBarView: View {
    var viewContext: NSManagedObjectContext
    var products: [FetchedResults<FavProduct>.Element]
    @ObservedObject var userService = UserService.shared
    var body: some View {
        TabView {
            MainView(viewModel: MainViewModel(viewContext: viewContext, products: products))
                .tabItem {
                    Image("tab-icon2")
                        .renderingMode(.template)
                    Text("Подборка")
                }
            CatalogView(viewModel: CatalogViewModel(viewContext: viewContext, products: products))
                .tabItem {
                    Image("tab-catalog")
                        .renderingMode(.template)
                    Text("Каталог")
                }
            FavoritesView(viewModel: FavoritesViewModel(viewContext: viewContext, products: products))
                .tabItem {
                    Image("tab-fav")
                        .renderingMode(.template)
                    Text("Избранное")
                }
            CartView(viewModel: CartViewModel(viewContext: viewContext, products: products))
                .tabItem {
                    Image("tab-cart")
                        .renderingMode(.template)
                    Text("Корзина")
                }
            ProfileView()
                .tabItem {
                    Image("tab-profile")
                        .renderingMode(.template)
                    Text("Профиль")
                }
        }
        .accentColor(.main)
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
        .onReceive(userService.$user, perform: { _ in
            ProductService.shared.updateProducts()
        })
    }
}

//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
//}
