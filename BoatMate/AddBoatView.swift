//
//  AddBoatView.swift
//  BoatMate
//
//  Created by Ruben Förstmann on 11.08.25.
//

import SwiftUI
import CoreData

struct AddBoatView: View {
    @Environment(\.managedObjectContext) private var ctx
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Bootsname", text: $name)
                        .textInputAutocapitalization(.words)
                }
            }
            .navigationTitle("Boot hinzufügen")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        addBoat()
                        dismiss()
                    }
                    .disabled(nameTrimmed.isEmpty)
                }
            }
        }
    }

    private var nameTrimmed: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func addBoat() {
        let boat = Boat(context: ctx)
        boat.name = nameTrimmed
        try? ctx.save()
    }
}

struct AddBoatView_Previews: PreviewProvider {
    static var previews: some View {
        AddBoatView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
