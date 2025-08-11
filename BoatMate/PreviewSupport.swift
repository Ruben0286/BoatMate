//
//  PreviewSupport.swift
//  BoatMate
//
//  Created by Ruben Förstmann on 10.08.25.
//

import SwiftUI
import CoreData

/// Gemeinsamer In‑Memory‑Container für alle Previews
enum PreviewCoreData {
    static let controller: PersistenceController = {
        let pc = PersistenceController(inMemory: true)
        return pc
    }()

    static var context: NSManagedObjectContext {
        controller.container.viewContext
    }
}

/// Bequemer Modifier: injiziert den Preview‑Context und optional Seed‑Daten
extension View {
    /// - Parameter seed: Optionale Seed‑Funktion, um Demo‑Daten in den Context zu schreiben
    func withPreviewContext(seed: ((NSManagedObjectContext) -> Void)? = nil) -> some View {
        let ctx = PreviewCoreData.context
        seed?(ctx)
        try? ctx.save()
        return self.environment(\.managedObjectContext, ctx)
    }
}
