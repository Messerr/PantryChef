//
//  RecipeCategory.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import Foundation
import SwiftUI

enum RecipeCategory: String, CaseIterable, Identifiable, Hashable, Codable {
    var id: Self { self }
    case breakfast
    case lunch
    case dinner
    case snack
    case dessert
    
    var displayName: String {
        switch self {
        case .breakfast:
            "Breakfast"
        case .lunch:
            "Lunch"
        case .dinner:
            "Dinner"
        case .snack:
            "Snack"
        case .dessert:
            "Dessert"
        }
    }
    
    var icon: String {
        switch self {
        case .breakfast:
            "sun.horizon.fill"
        case .lunch:
            "sun.max.fill"
        case .dinner:
            "sun.horizon"
        case .snack:
            "fork.knife"
        case .dessert:
            "moon.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .breakfast:
                .orange
        case .lunch:
                .green
        case .dinner:
                .blue
        case .snack:
                .purple
        case .dessert:
                .pink
        }
    }
}
