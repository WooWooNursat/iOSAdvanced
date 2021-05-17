//
//  MiniAppApp.swift
//  MiniApp
//
//  Created by Nursat on 09.05.2021.
//

import SwiftUI

@main
struct MiniAppApp: App {
    let persistenceContainer = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
