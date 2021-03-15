//
//  MapWithCoreDataApp.swift
//  MapWithCoreData
//
//  Created by Nursat on 24.02.2021.
//

import SwiftUI

@main
struct MapWithCoreDataApp: App {
    let persistenceContainer = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
