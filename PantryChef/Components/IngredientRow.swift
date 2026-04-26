//
//  IngredientRow.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import SwiftUI

struct IngredientRow: View {
    var ingredient: Ingredient
    var scale: Double
    var scaledAmount: Double {
        return ingredient.amount * scale
    }
    
    var body: some View {
        HStack {
            Text(FractionFormatter.format(ingredient.amount * scale))
                .font(.body.weight(.semibold))
                .frame(width: 40, alignment: .trailing)
            Text(ingredient.unit.abbreviatedUnit)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(width: 40, alignment: .leading)
            Text(ingredient.name)
                .font(.body)
        }
    }
}

#Preview {
    IngredientRow(
        ingredient: Ingredient(
            name: "Butter",
            amount: 3.4,
            unit: .cups,
            sortIndex: 1
        ),
        scale: 2
    )
}
