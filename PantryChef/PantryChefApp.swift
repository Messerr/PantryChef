//
//  PantryChefApp.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import SwiftUI
import SwiftData

@main
struct PantryChefApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Recipe.self, Ingredient.self, Step.self])
    }
}
