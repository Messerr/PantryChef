//
//  RecipeEditorScreen.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct RecipeEditorScreen: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var existingRecipe: Recipe?
    
    @State private var title = ""
    @State private var summary = ""
    @State private var servings = 4
    @State private var prepMinutes = 0
    @State private var cookMinutes = 0
    @State private var category: RecipeCategory = .dinner
    @State private var ingredientDrafts: [IngredientDraft] = []
    @State private var stepDrafts: [StepDraft] = []
    @State private var imageData: Data?
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Recipe Title", text: $title)
                    TextField("Summary", text: $summary)
                    Stepper("Servings: \(servings)", value: $servings, in: 1...20)
                    Picker("Category", selection: $category) {
                        ForEach(RecipeCategory.allCases) { cat in
                            Label(cat.displayName, systemImage: cat.icon).tag(cat)
                        }
                    }
                }
                
                Section("Timing") {
                    Stepper("Prep: \(prepMinutes) min", value: $prepMinutes, in: 0...300, step: 5)
                    Stepper("Cook: \(cookMinutes) min", value: $cookMinutes, in: 0...600, step: 5)
                }
                
                Section("Photo") {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        if let imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Label("Choose Photo", systemImage: "photo.on.rectangle.angled")
                        }
                    }
                    
                    if imageData != nil {
                        Button("Remove Photo", role: .destructive) {
                            imageData = nil
                            selectedItem = nil
                        }
                    }
                }
                .onChange(of: selectedItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data),
                               let compressed = uiImage.jpegData(compressionQuality: 0.7) {
                                imageData = compressed
                            }
                        }
                    }
                }
                
                Section {
                    ForEach($ingredientDrafts) { $draft in
                        IngredientDraftRow(draft: $draft)
                    }
                    .onDelete { indexSet in
                        ingredientDrafts.remove(atOffsets: indexSet)
                    }
                    
                    Button {
                        ingredientDrafts.append(IngredientDraft())
                    } label: {
                        Label("Add Ingredient", systemImage: "plus.circle")
                    }
                } header: { Text("Ingredients") }
                
                
                Section {
                    ForEach(Array(stepDrafts.enumerated()), id: \.element.id) { index, draft in
                        StepDraftRow(draft: $stepDrafts[index], index: index)
                    }
                    .onDelete { indexSet in
                        stepDrafts.remove(atOffsets: indexSet)
                    }
                    
                    Button {
                        stepDrafts.append(StepDraft())
                    } label: {
                        Label("Add Step", systemImage: "plus.circle")
                    }
                } header: { Text("Steps") }
            }
            .navigationTitle(existingRecipe != nil ? "Edit Recipe" : "New Recipe")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem {
                    Button("Save") { save() }
                        .disabled(title.isEmpty)
                }
            }
            .onAppear { prefillIfEditing() }
        }
    }
    
    private func save() {
        if let existingRecipe {
            existingRecipe.title = title
            existingRecipe.summary = summary
            existingRecipe.servings = servings
            existingRecipe.prepMinutes = prepMinutes
            existingRecipe.cookMinutes = cookMinutes
            existingRecipe.category = category
            
            existingRecipe.ingredients.forEach { context.delete($0) }
            existingRecipe.steps.forEach { context.delete($0) }
            existingRecipe.imageData = imageData
            
            for (i, draft) in ingredientDrafts.enumerated() {
                let ing = Ingredient(name: draft.name, amount: draft.amount,
                                     unit: draft.unit, sortIndex: i)
                ing.recipe = existingRecipe
                context.insert(ing)
            }

            for (i, draft) in stepDrafts.enumerated() {
                let step = Step(instruction: draft.instruction,
                                durationSeconds: draft.durationSeconds == 0 ? nil : draft.durationSeconds,
                                sortIndex: i)
                step.recipe = existingRecipe
                context.insert(step)
            }
        } else {
            let recipe = Recipe(
                title: title,
                summary: summary,
                servings: servings,
                prepMinutes: prepMinutes,
                cookMinutes: cookMinutes,
                category: category
            )
            recipe.imageData = imageData
            
            for (i, draft) in ingredientDrafts.enumerated() {
                let ing = Ingredient(
                    name: draft.name,
                    amount: draft.amount,
                    unit: draft.unit,
                    sortIndex: i
                )
                
                ing.recipe = recipe
                context.insert(ing)
            }
            
            for (i, draft) in stepDrafts.enumerated() {
                let step = Step(
                    instruction: draft.instruction,
                    durationSeconds: draft.durationSeconds == 0 ? nil : draft.durationSeconds,
                    sortIndex: i
                )
                
                step.recipe = recipe
                context.insert(step)
            }
            
            context.insert(recipe)
        }
        
        dismiss()
    }
    
    private func prefillIfEditing() {
        if let existingRecipe {
            title = existingRecipe.title
            summary = existingRecipe.summary
            servings = existingRecipe.servings
            prepMinutes = existingRecipe.prepMinutes
            cookMinutes = existingRecipe.cookMinutes
            category = existingRecipe.category
            imageData = existingRecipe.imageData
            
            ingredientDrafts = existingRecipe.sortedIngredients.map { ing in
                IngredientDraft(name: ing.name, amount: ing.amount, unit: ing.unit)
            }
            
            stepDrafts = existingRecipe.sortedSteps.map { step in
                StepDraft(instruction: step.instruction, durationSeconds: step.durationSeconds ?? 0)
            }
        }
    }
}

#Preview {
    RecipeEditorScreen()
}
