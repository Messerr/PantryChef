//
//  CategoryBadge.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import SwiftUI

struct CategoryBadge: View {
    var recipeCategory: RecipeCategory
    
    var body: some View {
        Text(recipeCategory.displayName)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(recipeCategory.color, in: Capsule())
            .foregroundStyle(.white)
    }
}

#Preview {
    CategoryBadge(recipeCategory: .breakfast)
    CategoryBadge(recipeCategory: .lunch)
    CategoryBadge(recipeCategory: .dinner)
    CategoryBadge(recipeCategory: .snack)
    CategoryBadge(recipeCategory: .dessert)
}
