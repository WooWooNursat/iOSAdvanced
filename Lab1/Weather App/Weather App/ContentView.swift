//
//  ContentView.swift
//  Weather App
//
//  Created by Nursat on 09.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var nightTime = false
    
    let screenSize = UIScreen.main.bounds
    var forecasts =
    [
        ["TUE", "cloud.sun.fill", "79°"],
        ["WD", "cloud.sun.rain.fill", "74°"],
        ["THU", "wind", "70°"],
        ["FRI", "wind.snow", "70°"],
        ["SAT", "cloud.sun.fill", "76°"]
    ]
    
    var body: some View {
        VStack(spacing: screenSize.height*15/568) {
            Text("Cupertino, CA")
                .fontWeight(.medium)
                .foregroundColor(.white)
                .font(.title)
            
            Image(systemName: nightTime ? "moon.stars.fill" : "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: screenSize.width*3/8, height: screenSize.height*15/71, alignment: .center)
                .foregroundColor(.white)
            
            Text("89°")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 50))
            
            HStack(spacing: screenSize.width/16) {
                ForEach(forecasts, id: \.self) { forecast in
                    VStack(spacing: screenSize.height*5/568) {
                        Text(forecast[0])
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                        Image(systemName: forecast[1])
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenSize.width*7/64, height: screenSize.height*35/568, alignment: .center)
                        Text(forecast[2])
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
            }.padding()
            
            Button(action: {
                self.nightTime.toggle()
            }) {
                Text(nightTime ? "Change night time" : "Change day time")
                    .fontWeight(.bold)
                    .font(.body)
            }.frame(maxWidth: .infinity)
            .padding(.vertical,screenSize.height*3/142)
            .background(Color.white)
            .cornerRadius(8.0)
            .padding(.all, screenSize.width/8)
        }
        .frame(width: screenSize.width, height: screenSize.height)
        .background(LinearGradient(gradient: Gradient(
                                    colors:
                                        [
                                            nightTime ? .black : Color(red: 32/255, green: 124/255, blue: 254/255),
                                            nightTime ? .gray : Color(red: 140/255, green: 224/255, blue: 255/255)
                                        ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
        ))
        .ignoresSafeArea(.all)
    }
}




























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 12")
        }
    }
}
