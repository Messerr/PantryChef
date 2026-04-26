//
//  CookingModeView.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import SwiftUI
import SwiftData

struct CookingModeView: View {
    let recipe: Recipe
    @State private var currentStepIndex = 0
    @Environment(\.dismiss) private var dismiss
    
    var steps: [Step] { recipe.sortedSteps }
    var currentStep: Step? { steps.indices.contains(currentStepIndex) ? steps[currentStepIndex] : nil }
 
    var body: some View {
        VStack(spacing: 0) {
            if !steps.isEmpty {
                ProgressView(value: Double(currentStepIndex + 1), total: Double(steps.count))
                    .tint(recipe.category.color)
                    .padding()
            }

            Spacer()
            
            if let step = currentStep {
                VStack(spacing: 24) {
                    Text("Step \(currentStepIndex + 1) of \(steps.count)")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                    
                    Text(step.instruction)
                        .font(.title2.weight(.medium))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    
                    if let seconds = step.durationSeconds {
                      CookingTimerView(totalSeconds: seconds)
                    }
                }
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                Button("Previous") { currentStepIndex -= 1 }
                    .disabled(currentStepIndex == 0)
                
                Button("Next") { currentStepIndex += 1 }
                    .disabled(currentStepIndex >= steps.count - 1)
            }
            .padding()
        }
        .padding(.top)
        .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
        .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
        .overlay(alignment: .topTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .padding(.top, 40)
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Recipe.self, Ingredient.self, Step.self,
                                         configurations: .init(isStoredInMemoryOnly: true))
    let context = container.mainContext

    let recipe = Recipe(title: "Pancakes", summary: "Fluffy!")
    context.insert(recipe)

    let step1 = Step(instruction: "Mix dry ingredients", durationSeconds: nil, sortIndex: 0)
    step1.recipe = recipe
    context.insert(step1)

    let step2 = Step(instruction: "Cook on griddle until bubbles form", durationSeconds: 180, sortIndex: 1)
    step2.recipe = recipe
    context.insert(step2)

    return CookingModeView(recipe: recipe)
        .modelContainer(container)
}
