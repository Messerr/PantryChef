//
//  IngredientDraftRow.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import SwiftUI

struct IngredientDraftRow: View {
    @Binding var draft: IngredientDraft
    
    var body: some View {
        HStack {
            TextField("Amount", value: $draft.amount, format: .number)
                .keyboardType(.decimalPad)
                .frame(width: 60)
            Picker("", selection: $draft.unit) {
                ForEach(MeasurementUnit.allCases) { unit in
                    Text(unit.abbreviatedUnit).tag(unit)
                }
            }
            .frame(width: 80)
            
            TextField("Ingredient name", text: $draft.name)
        }
    }
}

#Preview {
    @Previewable @State var draft = IngredientDraft()
    
    IngredientDraftRow(draft: $draft)
}
