//
//  CategoryChip.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import SwiftUI

struct CategoryChip: View {
    let category: RecipeCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label(category.displayName, systemImage: category.icon)
                .font(.caption.weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(
                    isSelected ? category.color : Color(.systemGray5),
                    in: Capsule()
                )
                .foregroundStyle(isSelected ? .white : .primary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CategoryChip(
        category: .dinner,
        isSelected: true,
        action: {}
    )
}
