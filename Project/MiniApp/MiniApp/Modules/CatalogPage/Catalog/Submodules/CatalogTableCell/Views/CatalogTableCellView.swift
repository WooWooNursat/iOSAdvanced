//
//  CatalogTableCellView.swift
//  MiniApp
//
//  Created by Nursat on 10.05.2021.
//

import SwiftUI

struct CatalogTableCellView: View {
    @State var category: Category;
    var body: some View {
        HStack(spacing: 16){
            Image("default-image")
                .resizable()
                .scaledToFill()
                .frame(width: 136, height: 80, alignment: .center)
                .clipped()
                .cornerRadius(4)
            Text(category.name)
                .font(.system(size: 20, weight: .medium))
            Spacer()
        }
        .background(Rectangle().fill(Color.white))
        .frame(width: 343, height: 80)
        .cornerRadius(4)
        .shadow(radius: 2)
    }
}

//struct CatalogTableCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CatalogTableCellView()
//    }
//}
