//
//  RecipeDetailScreen.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import SwiftUI
import SwiftData

struct RecipeDetailScreen: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    let recipe: Recipe
    @State private var adjustedServings: Int
    @State private var showingEditScreen = false
    @State private var showCookingMode = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self._adjustedServings = State(initialValue: recipe.servings)
    }
    
    private var scale: Double {
        Double(adjustedServings) / Double(recipe.servings)
    }
    
    private var recipeHeader: some View {
        VStack(spacing: 12) {
            CategoryBadge(recipeCategory: recipe.category)
            
            HStack(spacing: 16) {
                Label("\(recipe.prepMinutes) min prep", systemImage: "clock")
                Label("\(recipe.cookMinutes) min cook", systemImage: "flame")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            Stepper("Servings: \(adjustedServings)", value: $adjustedServings, in: 1...20)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                RecipePhotoPickerButton(recipe: recipe)
                
                recipeHeader
                
                SectionCard(title: "Ingredients", icon: "basket") {
                    ForEach(recipe.sortedIngredients) { ingredient in
                        IngredientRow(
                            ingredient: ingredient,
                            scale: scale
                        )
                    }
                }
                .animation(.easeInOut(duration: 0.2), value: adjustedServings)
                
                SectionCard(title: "Steps", icon: "list.number") {
                    ForEach(recipe.sortedSteps) { step in
                        StepRow(step: step)
                    }
                }
                
                Button {
                    showCookingMode = true
                } label: {
                    Label("Start Cooking", systemImage: "flame")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(recipe.category.color, in: RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.white)
                }
            }
            .padding()
        }
        .navigationTitle(recipe.title)
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                Button {
                    withAnimation(.spring(duration: 0.3, bounce: 0.4)) {
                        recipe.isFavorite.toggle()
                    }
                } label: {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(recipe.isFavorite ? .red : .secondary)
                        .scaleEffect(recipe.isFavorite ? 1.2 : 1.0)
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                Button("Delete") {
                    context.delete(recipe)
                    dismiss()
                }
            }
            ToolbarItem {
                Button("Edit") { showingEditScreen = true }
            }
        }
        .sheet(isPresented: $showingEditScreen) {
            RecipeEditorScreen(existingRecipe: recipe)
        }
        .fullScreenCover(isPresented: $showCookingMode) {
            CookingModeView(recipe: recipe)
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Recipe.self, Ingredient.self, Step.self,
                                         configurations: .init(isStoredInMemoryOnly: true))
    let context = container.mainContext

    let recipe = Recipe(title: "Fluffy Pancakes", summary: "Classic buttermilk pancakes",
                        servings: 4, prepMinutes: 10, cookMinutes: 15, category: .breakfast)
    context.insert(recipe)

    let flour = Ingredient(name: "Flour", amount: 1.5, unit: .cups, sortIndex: 0)
    flour.recipe = recipe
    context.insert(flour)

    let milk = Ingredient(name: "Milk", amount: 1, unit: .cups, sortIndex: 1)
    milk.recipe = recipe
    context.insert(milk)

    let step1 = Step(instruction: "Mix dry ingredients", durationSeconds: nil, sortIndex: 0)
    step1.recipe = recipe
    context.insert(step1)

    let step2 = Step(instruction: "Cook on griddle until bubbles form", durationSeconds: 180, sortIndex: 1)
    step2.recipe = recipe
    context.insert(step2)

    return RecipeDetailScreen(recipe: recipe)
        .modelContainer(container)
}
