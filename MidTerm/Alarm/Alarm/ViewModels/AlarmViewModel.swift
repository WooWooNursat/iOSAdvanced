//
//  AlarmViewModel.swift
//  Alarm
//
//  Created by Nursat on 18.03.2021.
//

import Foundation

class AlarmViewModel: ObservableObject {
    let dateFormatter = DateFormatter()
    @Published var alarms: [Alarm] = [
        Alarm(title: "title", date: Date())
    ]
    
    init() {
        dateFormatter.dateFormat = "HH:mm"
    }
    
    func createAlarm(title: String, date: Date) {
        self.alarms.append(Alarm(title: title, date: date))
    }
    
    func deleteAlarm(alarm: Alarm) {
        self.alarms.removeAll(where: { $0.id == alarm.id })
    }
    
    func deleteAlarm(at indexSet: IndexSet) {
        self.alarms.remove(atOffsets: indexSet)
    }
    
    func editAlarm(title: String, date: Date, alarm: Alarm) {
        let newAlarm = Alarm(title: title, date: date, enabled: alarm.enabled, id: alarm.id)
        self.alarms[self.alarms.firstIndex(where: {$0.id == alarm.id })!] = newAlarm
    }
}
