//
//  SampleDataSeeder.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import Foundation
import SwiftData

struct SampleDataSeeder {
    @MainActor
    static func seedIfNeeded(context: ModelContext) {
        let descriptor = FetchDescriptor<Recipe>()
        let count = (try? context.fetchCount(descriptor)) ?? 0
        guard count == 0 else { return }
        
        let pancakes = Recipe(
            title: "Fluffy Pancakes",
            summary: "Classic buttermilk pancakes",
            servings: 4, prepMinutes: 10, cookMinutes: 15,
            category: .breakfast
        )
        
        let flour = Ingredient(
            name: "All-purpose flour",
            amount: 1.5,
            unit: .cups,
            sortIndex: 0
        )
        
        flour.recipe = pancakes
        
        let milk = Ingredient(
            name: "Buttermilk",
            amount: 1.25,
            unit: .cups,
            sortIndex: 1
        )
        
        milk.recipe = pancakes
        
        let step1 = Step(
            instruction: "Mix dry ingredients in a large bowl",
            durationSeconds: nil,
            sortIndex: 0
        )
        
        step1.recipe = pancakes
        
        let step2 = Step(
            instruction: "Cook on griddle until bubbles form",
            durationSeconds: 180,
            sortIndex: 1
        )
        
        step2.recipe = pancakes
        
        context.insert(pancakes)
    }
}
