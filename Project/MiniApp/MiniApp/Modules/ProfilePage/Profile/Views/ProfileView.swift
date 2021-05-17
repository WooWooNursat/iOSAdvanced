//
//  ProfileView.swift
//  MiniApp
//
//  Created by Nursat on 11.05.2021.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack(alignment: .top) {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 4) {
                            Image(viewModel.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 125, height: 125, alignment: .center)
                            if !viewModel.isEditing {
                                let bool = viewModel.firstName.isEmpty && viewModel.lastName.isEmpty
                                Text(bool ? "Нет имени и фамилии" : viewModel.firstName + " " + viewModel.lastName)
                                    .font(.system(size: 20, weight: .semibold))
                                Text(viewModel.email)
                                    .font(.system(size: 14, weight: .regular))
                            } else {
                                VStack(spacing: 8) {
                                    HStack {
                                        Text("Имя:")
                                            .padding(.horizontal)
                                            .font(.system(size: 20, weight: .regular))
                                        TextField("Введите имя", text: $viewModel.firstName)
                                            .padding(.horizontal)
                                            .font(.system(size: 20, weight: .semibold))
                                            .multilineTextAlignment(.trailing)
                                    }
                                    .border(Color.black, width: 1)
                                    HStack {
                                        Text("Фамилия:")
                                            .padding(.horizontal)
                                            .font(.system(size: 20, weight: .regular))
                                        TextField("Введите фамилию", text: $viewModel.lastName)
                                            .padding(.horizontal)
                                            .font(.system(size: 20, weight: .semibold))
                                            .multilineTextAlignment(.trailing)
                                    }
                                    .border(Color.black, width: 1)
                                    
                                Text(viewModel.email)
                                    .font(.system(size: 14, weight: .regular))
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        Spacer()
                    }
                    HStack {
                        VStack {
                            NavigationLink(destination: CardView(), label: {
                                Image("card")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .padding(.leading, 16)
                            })
                        }
                        Spacer()
                        VStack {
                            Button(action: {
                                viewModel.setUser()
                            }, label: {
                                Image("pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .padding(.trailing, 16)
                            })
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Номер телефона")
                        .font(.system(size: 20, weight: .semibold))
                    if !viewModel.isEditing {
                        Text(viewModel.phone.isEmpty ? "Нет номера" : viewModel.phone)
                            .font(.system(size: 14, weight: .medium))
                    } else {
                        HStack {
                            TextField("Введите номер телефона", text: $viewModel.phone)
                                .font(.system(size: 14, weight: .medium))
                                .frame(width: 165)
                                .border(Color.black, width: 1)
                        }
                    }
                }
                .padding(.top, 28)
                .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Популярные вопросы")
                        .font(.system(size: 20, weight: .semibold))
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        Text("Служба поддержки")
                            .underline()
                            .font(.system(size: 14, weight: .medium))
                    })
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        Text("Промо-код")
                            .underline()
                            .font(.system(size: 14, weight: .medium))
                    })
                    NavigationLink(
                        destination: OrderHistoryView(),
                        label: {
                            Text("История заказов")
                                .underline()
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.main)
                        })
                }
                .padding(.top, 28)
                .padding(.horizontal, 16)
                
                Button(action: {
                    viewModel.logout()
                }, label: {
                    Text("Выйти")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.red)
                })
                .padding(.top, 42)
                .padding(.horizontal, 16)
                Spacer()
            }
            .padding(.top)
            .navigationBarTitle("Профиль", displayMode: .inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
