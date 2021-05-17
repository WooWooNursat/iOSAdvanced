//
//  CartView.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Всего")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    Text("\(viewModel.getTotal()) ₸")
                        .font(.system(size: 20, weight: .bold))
                }
                .padding(.vertical)
                .padding(.horizontal, 16)
                Spacer()
                ZStack(alignment: .bottom) {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(viewModel.products, id: \.id) { product in
                            ZStack(alignment: .topTrailing) {
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
                                VStack {
                                    Button(action: {
                                        viewModel.removeFromCart(product: product)
                                    }, label: {
                                        Image(systemName: "minus.circle.fill")
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20, alignment: .center)
                                            .foregroundColor(.red)
                                    })
                                    Spacer()
                                }
                                .padding(.horizontal, 8)
                                .padding(.top, 26)
                            }
                            
                        }
                    }
                    Button(action: {
                        viewModel.order()
                    }, label: {
                        Text("Заказать")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                    })
                    .frame(width: 343, height: 48)
                    .background(Color.main)
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                }
            }
            .onAppear(perform: {
                viewModel.updateList()
            })
            .alert(isPresented: $viewModel.noBalance, content: {
                Alert(title: Text("Ошибка"), message: Text("Не хватает золота"), dismissButton: .default(Text("Ok")))
            })
            .navigationBarTitle("Корзина", displayMode: .inline)
        }
    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
