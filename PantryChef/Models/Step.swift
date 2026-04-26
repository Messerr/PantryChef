//
//  Step.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import Foundation
import SwiftData

@Model
final class Step {
    var instruction: String
    var durationSeconds: Int?
    var sortIndex: Int
    
    @Relationship
    var recipe: Recipe?
    
    init(
        instruction: String,
        durationSeconds: Int? = 0,
        sortIndex: Int,
        recipe: Recipe? = nil
    ) {
        self.instruction = instruction
        self.durationSeconds = durationSeconds
        self.sortIndex = sortIndex
        self.recipe = recipe
    }
}
