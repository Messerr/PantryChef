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
    @Query(filter: #Predicate<Recipe> { $0.isFavorite })
    private var favoriteRecipes: [Recipe]
    
    var body: some View {
        TabView {
            Tab("Recipes", systemImage: "book") {
                NavigationStack {
                    RecipeBrowseScreen()
                        .navigationDestination(for: Recipe.self) { recipe in
                            RecipeDetailScreen(recipe: recipe)
                        }
                }
            }
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    FavoritesScreen()
                        .navigationDestination(for: Recipe.self) { recipe in
                            RecipeDetailScreen(recipe: recipe)
                        }
                }
            }
            .badge(favoriteRecipes.count)
        }
        .task {
            SampleDataSeeder.seedIfNeeded(context: context)
        }
    }
}

#Preview {
    ContentView()
}
