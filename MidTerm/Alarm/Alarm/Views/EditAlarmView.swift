//
//  EditAlarmView.swift
//  Alarm
//
//  Created by Nursat on 18.03.2021.
//

import SwiftUI

struct EditAlarmView: View {
    @Environment(\.presentationMode) var presentationMode
    private var viewModel: AlarmViewModel
    let alarm: Alarm
    @State var alarmDate: Date
    @State var alarmTitle: String
    
    init(viewModel: AlarmViewModel, alarm: Alarm) {
        self.viewModel = viewModel
        self.alarm = alarm
        _alarmDate = State(initialValue: alarm.date)
        _alarmTitle = State(initialValue: alarm.title)
    }
    var body: some View {
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
            VStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    viewModel.deleteAlarm(alarm: alarm)
                }, label: {
                    Text("Delete")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium))
                })
                .padding(.vertical, 5)
                .background(Color.red)
                .padding(.horizontal, 20)
                Button(action: {
                    viewModel.editAlarm(title: self.alarmTitle, date: self.alarmDate, alarm: alarm)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Change")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium))
                })
                .padding(.vertical, 5)
                .background(Color.blue)
                .padding(.horizontal, 20)
            }
        }
        .navigationBarTitle("Change Alarm", displayMode: .inline)
    }
}
