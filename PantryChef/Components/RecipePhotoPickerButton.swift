//
//  RecipePhotoPickerButton.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import SwiftUI
import PhotosUI

struct RecipePhotoPickerButton: View {
    let recipe: Recipe
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        PhotosPicker(selection: $selectedItem,
                     matching: .images) {
            if let data = recipe.imageData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(recipe.category.color.opacity(0.15))
                    .frame(height: 200)
                    .overlay {
                        Label("Add Photo", systemImage: "camera")
                            .foregroundStyle(recipe.category.color)
                    }
            }
        }
         .onChange(of: selectedItem) { _, newItem in
             Task {
                 if let data = try? await newItem?.loadTransferable(type: Data.self) {
                     if let uiImage = UIImage(data: data),
                        let compressed = uiImage.jpegData(compressionQuality: 0.7) {
                         recipe.imageData = compressed
                     }
                 }
             }
         }
    }
}

#Preview {
    RecipePhotoPickerButton(recipe: Recipe(
        title: "Recipe",
        summary: "Recipe"
    ))
}
