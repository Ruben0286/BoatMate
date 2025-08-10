//
//  BoatMateApp.swift
//  BoatMate
//
//  Created by Ruben Förstmann on 10.08.25.
//

import SwiftUI

@main
struct BoatMateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
