//
//  RecipeCard.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RecipeImageView(data: recipe.imageData, recipeCategory: recipe.category)
            .overlay(alignment: .topTrailing) {
                if recipe.isFavorite {
                Image(systemName: "heart.fill")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(6)
                    .background(.red, in: Circle())
                    .padding(8)
                    .transition(.scale.combined(with: .opacity))
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.headline)
                    .lineLimit(2)
                
                HStack(spacing: 12) {
                    Label("\(recipe.totalMinutes) min", systemImage: "clock")
                    Label("\(recipe.servings)", systemImage: "person.2")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
        .animation(.spring(duration: 0.3), value: recipe.isFavorite)
    }
}

#Preview {
    RecipeCard(recipe: Recipe(
        title: "Fluffy Pancakes",
        summary: "Clasics buttermilk pancakes",
        servings: 4, prepMinutes: 10, cookMinutes: 15,
        category: .breakfast
    ))
}
