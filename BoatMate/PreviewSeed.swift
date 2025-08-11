//
//  PreviewSeed.swift
//  BoatMate
//
//  Created by Ruben Förstmann on 10.08.25.
//

import CoreData

enum PreviewSeed {
    /// Beispiel: ein paar Boote anlegen
    static func boats(_ ctx: NSManagedObjectContext) {
        for name in ["Aurora", "Mistral", "Nordlicht"] {
            let b = Boat(context: ctx)
            b.name = name
        }
    }

    // Hier kannst du später weitere Seeder ergänzen, z. B.:
    // static func expenses(_ ctx: NSManagedObjectContext) { ... }
    // static func maintenance(_ ctx: NSManagedObjectContext) { ... }
}


// Seed in Preview einbinden mittels:
//struct BoatListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoatListView()
//            .withPreviewContext(seed: PreviewSeed.boats) // 👈 Einzeiler
//    }
//}

