//
//  RecipeImageView.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import SwiftUI

struct RecipeImageView: View {
    var data: Data?
    var recipeCategory: RecipeCategory
    
    var body: some View {
        Group {
            if let data, let uiImage = UIImage(data: data) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                    .overlay {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(recipeCategory.color.opacity(0.15))
                    .frame(height: 140)
                    .overlay {
                        Image(systemName: recipeCategory.icon)
                            .font(.largeTitle)
                            .foregroundColor(recipeCategory.color)
                    }
            }
        }
    }
}

#Preview {
    RecipeImageView(
        recipeCategory: .dinner
    )
}
