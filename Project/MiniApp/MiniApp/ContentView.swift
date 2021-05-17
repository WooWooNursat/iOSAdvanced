//
//  ContentView.swift
//  MiniApp
//
//  Created by Nursat on 09.05.2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: FavProduct.newFetchRequest) private var products: FetchedResults<FavProduct>
    @ObservedObject var userService = UserService.shared
    var body: some View {
        if userService.user != nil {
            TabBarView(viewContext: viewContext, products: products.filter({ $0.userId == userService.user!.id }))
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
