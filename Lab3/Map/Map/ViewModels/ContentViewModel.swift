//
//  ContentViewModel.swift
//  Map
//
//  Created by Nursat on 23.02.2021.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var marks: [Mark] = []
    @Published var mapType: String
    @Published var currentPlace: Mark?
    var currentIndex: Int
    var mapTypes = [
        "Normal",
        "Satellite",
        "Hybrid"
    ]
    var mark: Mark?
    
    init() {
        mapType = "Normal"
        currentIndex = 0
    }
    
    func saveMark(markTitle: String, markDescription: String, latitude: Float, longitude: Float) {
        guard let mark = mark else { return }
        mark.markTitle = markTitle
        mark.markDescription = markDescription
        mark.markLatitude = latitude
        mark.markLongitude = longitude
        currentPlace = mark
    }
}
