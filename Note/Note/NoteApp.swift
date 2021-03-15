//
//  NoteApp.swift
//  Note
//
//  Created on 3/15/21.
//

import SwiftUI

@main
struct NoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
