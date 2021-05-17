//
//  SideBarView.swift
//  MiniApp
//
//  Created by Nursat on 10.05.2021.
//

import SwiftUI

struct SideBarView: View {
    @Binding var showSideBar: Bool
    @ObservedObject var viewModel = SideBarViewModel()
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .contentShape(Rectangle())
                .foregroundColor(.clear)
                .onTapGesture {
                    showSideBar = false
                }
            VStack {
                Image("logo_transparent")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 44)
                List {
                    ForEach(viewModel.items, id: \.id) { item in
                        HStack {
                            Image(item.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                            Text(item.name)
                                .font(.system(size: 16, weight: .medium))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.main)
                                .frame(width: 14, height: 14)
                        }
                        .onTapGesture {
                            viewModel.changeProductType(item: item)
                        }
                        .frame(height: 40)
                    }
                }
                Spacer()
            }
            .transition(.move(edge: .leading))
            .animation(.easeInOut(duration: 0.3))
            .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height)
            .background(Color.white)
            .ignoresSafeArea()
        }
    }
}

//struct SideBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideBarView()
//    }
//}
