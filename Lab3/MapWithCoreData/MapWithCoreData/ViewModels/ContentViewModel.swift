//
//  ContentViewModel.swift
//  MapWithCoreData
//
//  Created by Nursat on 24.02.2021.
//

import Foundation
import CoreData

class ContentViewModel: ObservableObject {
    @Published var mapType: String = "Normal"
    @Published var currentPlace: Mark?
    @Published var openEditView: Bool = false
    @Published var showAlert: Bool = false
    var coordinate: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    var currentIndex: Int = 0
    var mapTypes = [
        "Normal",
        "Satellite",
        "Hybrid"
    ]
    
    func showAlert(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        showAlert = true
    }
    
    func editMark(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        openEditView = true
    }
    
    func saveContext(viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
        }
        catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
    func addMark(viewContext: NSManagedObjectContext, title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        let newMark = Mark(context: viewContext)
        newMark.markTitle = title
        newMark.markSubtitle = subtitle
        newMark.markLatitude = Float(coordinate.latitude)
        newMark.markLongitude = Float(coordinate.longitude)
        currentPlace = newMark
        saveContext(viewContext: viewContext)
    }
}
