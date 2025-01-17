//
//  BrainSysApp.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/22/24.
//

import SwiftUI
import SwiftData

@main
struct BrainSysApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabBarHome()
        }
        .modelContainer(sharedModelContainer)
    }
}
