//
//  CreateAlarmView.swift
//  Alarm
//
//  Created by Nursat on 18.03.2021.
//

import SwiftUI

struct CreateAlarmView: View {
    @Environment(\.presentationMode) var presentationMode
    private var viewModel: AlarmViewModel
    @State var alarmDate: Date = Date()
    @State var alarmTitle: String = ""
    
    init(viewModel: AlarmViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(alignment: .center) {
                    Spacer()
                    DatePicker("Pick date", selection: $alarmDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                    TextField("Enter title", text: $alarmTitle)
                        .padding(10)
                        .border(Color.gray, width: 0.5)
                        .cornerRadius(6)
                        .padding(20)
                    Spacer()
                }
                Button(action: {
                    viewModel.createAlarm(title: self.alarmTitle, date: self.alarmDate)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium))
                })
                .padding(.vertical, 5)
                .background(Color.blue)
                .padding(.horizontal, 20)
            }
            .navigationBarTitle("New Alarm", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }))
        }
    }
}
