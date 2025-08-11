//
//  BoatListView.swift
//  BoatMate
//
//  Created by Ruben Förstmann on 10.08.25.
//

import SwiftUI
import CoreData

struct BoatListView: View {
    @Environment(\.managedObjectContext) private var ctx

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Boat.name, ascending: true)],
        animation: .default
    )
    private var boats: FetchedResults<Boat>

    @State private var showAdd = false
    @State private var editingBoat: Boat?

    var body: some View {
        NavigationStack {
            List {
                ForEach(boats) { boat in
                    Text(boat.name ?? "Unbenannt")
                        .onTapGesture { editingBoat = boat }
                        .swipeActions {
                            Button("Bearbeiten") { editingBoat = boat }
                        }
                }
                .onDelete(perform: deleteBoats)
            }
            .navigationTitle("Boote")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showAdd = true } label: { Image(systemName: "plus") }
                }
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAdd) {
                AddBoatView()
                    .environment(\.managedObjectContext, ctx)
            }
            .sheet(item: $editingBoat) { boat in
                EditBoatView(boat: boat)
                    .environment(\.managedObjectContext, ctx)
            }
        }
    }

    private func deleteBoats(at offsets: IndexSet) {
        withAnimation {
            offsets.map { boats[$0] }.forEach(ctx.delete)
            try? ctx.save()
        }
    }
}

struct BoatListView_Previews: PreviewProvider {
    static var previews: some View {
        BoatListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


