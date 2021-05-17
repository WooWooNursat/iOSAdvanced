//
//  Alarm.swift
//  Alarm
//
//  Created by Nursat on 18.03.2021.
//

import Foundation

struct Alarm: Identifiable {
    var title: String
    var date: Date
    var enabled = true
    var id = UUID()
}
