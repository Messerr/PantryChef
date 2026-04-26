//
//  ContentView.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            RecipeBrowseScreen()
                .navigationDestination(for: Recipe.self) { recipe in
                    RecipeDetailScreen(recipe: recipe)
                }
        }
        .task {
            SampleDataSeeder.seedIfNeeded(context: context)
        }
    }
}

#Preview {
    ContentView()
}
