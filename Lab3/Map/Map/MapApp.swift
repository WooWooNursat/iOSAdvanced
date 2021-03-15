//
//  MapApp.swift
//  Map
//
//  Created by Nursat on 23.02.2021.
//

import SwiftUI

@main
struct MapApp: App {
    let persistenceContainer = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
