//
//  LoginView.swift
//  MiniApp
//
//  Created by Nursat on 09.05.2021.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        VStack {
            Image("logo_transparent")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
                .padding(.vertical, 50)
                .offset(x: 0, y: !viewModel.animate ? 200 : 0)
                .animation(Animation.easeInOut(duration: 0.3))
            VStack {
                TextField("Введите почту", text: $viewModel.email)
                    .padding(10)
                    .border(Color.gray, width: 0.5)
                    .cornerRadius(6)
                    .padding(20)
                SecureField("Введите пароль", text: $viewModel.password)
                    .padding(10)
                    .border(Color.gray, width: 0.5)
                    .cornerRadius(6)
                    .padding(20)
                Button(action: {
                    if !viewModel.isRegistration {
                        viewModel.login()
                    } else {
                        viewModel.register()
                    }
                }, label: {
                    Text(!viewModel.isRegistration ? "Войти" : "Зарегистрироваться")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium))
                })
                .frame(width: 343, height: 48)
                .background(Color.main)
                .cornerRadius(10)
                HStack {
                    Text(!viewModel.isRegistration ? "Нет аккаунта?" : "Есть аккаунт?")
                    Button(!viewModel.isRegistration ? "Регистрация" : "Авторизация", action: {
                        viewModel.isRegistration.toggle()
                    })
                }
                .padding(.top, 10)
                .font(.system(size: 14, weight: .regular))
            }
            .opacity(!viewModel.animate ? 0 : 1)
            .animation(Animation.linear(duration: 0.3))
            Spacer()
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.animate = true
            }
        })
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text("Email or password is incorrect"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
