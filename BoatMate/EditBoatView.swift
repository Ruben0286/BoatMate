//
//  EditBoatView.swift
//  BoatMate
//
//  Created by Ruben Förstmann on 11.08.25.
//

import SwiftUI
import CoreData

struct EditBoatView: View {
    @ObservedObject var boat: Boat
    @Environment(\.managedObjectContext) private var ctx
    @Environment(\.dismiss) private var dismiss

    @State private var name: String

    init(boat: Boat) {
        self._boat = ObservedObject(initialValue: boat)
        self._name = State(initialValue: boat.name ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Bootsname", text: $name)
                        .textInputAutocapitalization(.words)
                }
            }
            .navigationTitle("Boot bearbeiten")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Sichern") { save() }
                        .disabled(nameTrimmed.isEmpty)
                }
            }
        }
    }

    private var nameTrimmed: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func save() {
        boat.name = nameTrimmed
        do {
            try ctx.save()
            dismiss()
        } catch {
            // Für v0.1 simpel: Fehler ignorieren/loggen
            // In v0.2 ggf. Fehleranzeige per Alert
            dismiss()
        }
    }
}

struct EditBoatView_Previews: PreviewProvider {
    static var previews: some View {
        let pc = PersistenceController.preview
        let ctx = pc.container.viewContext

        // Beispiel-Objekt für die Preview
        let b = Boat(context: ctx)
        b.name = "Aurora"
        try? ctx.save()

        return EditBoatView(boat: b)
            .environment(\.managedObjectContext, ctx)
    }
}
