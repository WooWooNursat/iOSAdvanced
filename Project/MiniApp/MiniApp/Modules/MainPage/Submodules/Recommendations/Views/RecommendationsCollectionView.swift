//
//  RecommendationsCollectionView.swift
//  MiniApp
//
//  Created by Nursat on 10.05.2021.
//

import SwiftUI

struct RecommendationsCollectionView: View {
    @ObservedObject var viewModel: RecommendationsCollectionViewModel
    @ObservedObject var productService: ProductService = ProductService.shared
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.collectionType.rawValue)
                .padding(.bottom, 14)
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.products, id: \.id) { product in
                        NavigationLink(
                            destination: ProductInfoView(viewModel: ProductInfoViewModel(product: product, viewContext: viewModel.viewContext, products: viewModel.favProducts)),
                            label: {
                                VStack(alignment: .leading) {
                                    if let image = product.image {
                                        RemoteImage(url: image)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 148, height: 100, alignment: .center)
                                            .cornerRadius(10)
                                            .padding(.bottom, 8)
                                    } else {
                                        Image(product.image ?? "default-image")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 148, height: 100, alignment: .center)
                                            .cornerRadius(10)
                                            .padding(.bottom, 8)
                                    }
                                    
                                    Text(product.name)
                                        .font(.system(size: 14, weight: .semibold))
                                        .padding(.bottom, 2)
                                    Text("\(product.price) тг")
                                        .font(.system(size: 14, weight: .regular))
                                }.foregroundColor(.black)
                            })
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .onReceive(productService.$food, perform: { _ in
            viewModel.products = ProductService.shared.productType == .wear ? ProductService.shared.wear : ProductService.shared.food
        })
    }
}

//struct RecommendationsCollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendationsCollectionView()
//    }
//}
