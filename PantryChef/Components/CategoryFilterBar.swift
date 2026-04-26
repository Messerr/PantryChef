//
//  CategoryFilterBar.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import SwiftUI

struct CategoryFilterBar: View {
    @Binding var selected: Set<RecipeCategory>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(RecipeCategory.allCases) { category in
                    CategoryChip(
                        category: category,
                        isSelected: selected.contains(category)
                    ) {
                        if selected.contains(category) {
                            selected.remove(category)
                        } else {
                            selected.insert(category)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    @Previewable @State var selected: Set<RecipeCategory> = [.dinner]
    
    CategoryFilterBar(selected: $selected)
}
