//
//  ContentView.swift
//  Alarm
//
//  Created by Nursat on 18.03.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AlarmViewModel()
    @State var showCreateView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.alarms) { alarm in
                    let binding = Binding(
                        get: { alarm.enabled },
                        set: { viewModel.alarms[viewModel.alarms.firstIndex(where: { $0.id == alarm.id })!].enabled = $0 }
                    )
                    ZStack {
                        NavigationLink(
                            destination: EditAlarmView(viewModel: viewModel, alarm: alarm),
                            label: {
                                EmptyView()
                                    .frame(width: 0)
                            })
                            .hidden()
                        HStack {
                            VStack {
                                Text(viewModel.dateFormatter.string(from: alarm.date))
                                    .font(.title)
                                    .bold()
                                Text(alarm.title)
                                    .font(.title3)
                            }
                            .padding(.leading)
                            Spacer()
                            Toggle("", isOn: binding)
                            .labelsHidden()
                        }
                    }
                    
                }
                .onDelete(perform: viewModel.deleteAlarm)
            }
            .padding(.horizontal, 8)
            .listStyle(PlainListStyle())
            .navigationBarTitle("Alarms", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Image(systemName: "plus")
                                    .foregroundColor(.blue)
                                    .onTapGesture(perform: {
                                        self.showCreateView.toggle()
                                    }))
            .ignoresSafeArea()
            .sheet(isPresented: $showCreateView, content: {
                CreateAlarmView(viewModel: viewModel)
            })
        }
    }
}




















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
