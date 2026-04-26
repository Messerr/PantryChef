//
//  Recipe.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var summary: String
    var servings: Int
    var prepMinutes: Int
    var cookMinutes: Int
    var category: RecipeCategory
    var isFavorite: Bool
    var dateCreated: Date
    var imageData: Data?
    
    @Relationship(deleteRule: .cascade)
    var ingredients: [Ingredient] = []
    
    @Relationship(deleteRule: .cascade)
    var steps: [Step] = []
    
    var totalMinutes: Int { prepMinutes + cookMinutes }
    
    var sortedIngredients: [Ingredient] {
        ingredients.sorted { $0.sortIndex < $1.sortIndex }
    }
    
    var sortedSteps: [Step] {
        steps.sorted { $0.sortIndex < $1.sortIndex }
    }
    
    init(
        title: String,
        summary: String = "",
        servings: Int = 4,
        prepMinutes: Int = 0,
        cookMinutes: Int = 0,
        category: RecipeCategory = .dinner
    ) {
        self.title = title
        self.summary = summary
        self.servings = servings
        self.prepMinutes = prepMinutes
        self.cookMinutes = cookMinutes
        self.category = category
        self.isFavorite = false
        self.dateCreated = .now
        self.imageData = nil
        self.ingredients = []
        self.steps = []
    }
}
