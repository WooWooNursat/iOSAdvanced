//
//  OrderHistoryView.swift
//  MiniApp
//
//  Created by Nursat on 13.05.2021.
//

import SwiftUI

struct OrderHistoryView: View {
    @ObservedObject var viewModel = OrderHistoryViewModel()
    var body: some View {
        List {
            ForEach(viewModel.orders, id: \.id) { order in
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("Заказ №\(order.id)")
                            .font(.system(size: 14))
                        Text("Курьер: \(order.courier?.firstName ?? "Имя") \(order.courier?.lastName ?? "Фамилия")")
                            .font(.system(size: 14))
                    }
                    .frame(height: 40)
                    Spacer()
                    if order.isDelivered {
                        Text("Доставлено")
                            .font(.system(size: 12))
                    } else {
                        Button(action: {
                            viewModel.deleteOrder(id: order.id)
                        }, label: {
                            Image(systemName: "minus.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(.red)
                        })
                    }
                }
            }
        }
        .onAppear {
            viewModel.getOrders()
        }
    }
}

//struct OrderHistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderHistoryView()
//    }
//}
