//
//  RecipeBrowseScreen.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import SwiftUI
import SwiftData

struct RecipeBrowseScreen: View {
    @Query(sort: \Recipe.title) private var recipes: [Recipe]
    @State private var showRecipeEdit = false
    @State private var selectedCategories: Set<RecipeCategory> = []
    @State private var searchText = ""
    
    var filteredRecipes: [Recipe] {
        var result = recipes
        
        if !selectedCategories.isEmpty {
            result = result.filter { selectedCategories.contains($0.category) }
        }
        
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.summary.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return result
    }
    
    var body: some View {
        ScrollView {
            CategoryFilterBar(selected: $selectedCategories)
            
            if filteredRecipes.isEmpty {
                if recipes.isEmpty {
                    ContentUnavailableView {
                        Label("No Recipes Yet", systemImage: "book.closed")
                    } description: {
                        Text("Tap + to add your first recipe.")
                    }
                } else if !searchText.isEmpty {
                    ContentUnavailableView {
                        Label("No Results", systemImage: "magnifyingglass")
                    } description: {
                        Text("No recipes match \"\(searchText)\"")
                    } actions: {
                        Button("Clear Search") { searchText = "" }
                    }
                } else {
                    ContentUnavailableView {
                        Label("No Matches", systemImage: "line.3.horizontal.decrease.circle")
                    } description: {
                        Text("No recipes match the selected filters.")
                    } actions: {
                        Button("Clear Filters") { selectedCategories = [] }
                    }
                }
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 170), spacing: 16)], spacing: 16) {
                    ForEach(filteredRecipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCard(recipe: recipe)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .animation(.spring(duration: 0.4), value: filteredRecipes.map(\.id))
            }
        }
        .searchable(text: $searchText, prompt: "Search recipes...")
        .searchSuggestions {
            ForEach(recipes.filter { $0.title.localizedCaseInsensitiveContains(searchText) } ) { recipe in
                Text(recipe.title).searchCompletion(recipe.title)
            }
        }
        .navigationTitle("Recipes")
        .toolbar {
            ToolbarItem {
                Button {
                    showRecipeEdit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showRecipeEdit) {
            RecipeEditorScreen()
        }
    }
}

#Preview {
    RecipeBrowseScreen()
}
