//
//  Ingredient.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import Foundation
import SwiftData

@Model
final class Ingredient {
    var name: String
    var amount: Double
    var unit: MeasurementUnit
    var sortIndex: Int
    
    @Relationship
    var recipe: Recipe?
    
    init(
        name: String,
        amount: Double,
        unit: MeasurementUnit,
        sortIndex: Int,
        recipe: Recipe? = nil
    ) {
        self.name = name
        self.amount = amount
        self.unit = unit
        self.sortIndex = sortIndex
        self.recipe = recipe
    }
}
