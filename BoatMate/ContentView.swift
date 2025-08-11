//
//  ContentView.swift
//  BoatMate
//
//  Created by Ruben Förstmann on 10.08.25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        BoatListView()   // nur ein Delegate/Wrapper
    }
}

private struct ContentEmptyState: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "sailboat")
                .font(.system(size: 48))
            Text("Noch keine Boote")
                .font(.headline)
            Text("Tippe auf „+“, um dein erstes Boot anzulegen.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .multilineTextAlignment(.center)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

