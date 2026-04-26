//
//  IngredientDraft.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import Foundation
import SwiftData

@Observable
final class IngredientDraft: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var unit: MeasurementUnit
    
    init(
        id: UUID = UUID(),
        name: String = "",
        amount: Double = 0,
        unit: MeasurementUnit = .cups
    ) {
        self.id = id
        self.name = name
        self.amount = amount
        self.unit = unit
    }
}
