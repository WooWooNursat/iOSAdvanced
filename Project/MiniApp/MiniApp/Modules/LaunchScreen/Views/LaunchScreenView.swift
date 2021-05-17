//
//  LaunchScreenView.swift
//  MiniApp
//
//  Created by Nursat on 09.05.2021.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        Image("logo_transparent")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200, alignment: .center)
            .padding(.bottom, 100)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
