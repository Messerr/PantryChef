//
//  FavoritesScreen.swift
//  PantryChef
//
//  Created by David Messer on 4/26/26.
//

import SwiftUI
import SwiftData

struct FavoritesScreen: View {
    @Query(filter: #Predicate<Recipe> { $0.isFavorite }, sort: \Recipe.title)
    private var favorites: [Recipe]
    
    var body: some View {
        ScrollView {
            if favorites.isEmpty {
                ContentUnavailableView {
                    Label("No Favorites Yet", systemImage: "heart.slash")
                } description: {
                    Text("Tap the heart on any recipe to add it here.")
                }
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 170), spacing: 16)], spacing: 16) {
                    ForEach(favorites) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCard(recipe: recipe)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoritesScreen()
        .modelContainer(for: [Recipe.self, Ingredient.self, Step.self], inMemory: true)
}
