//
//  MeasurementUnit.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import Foundation

enum MeasurementUnit: String, CaseIterable, Identifiable, Hashable, Codable {
    var id: Self { self }
    case cups
    case tablespoons
    case teaspoons
    case grams
    case ounces
    case pounds
    case ml
    case liters
    case pieces
    case pinch
    
    var abbreviatedUnit: String {
        switch self {
        case .cups: return "c"
        case .tablespoons: return "tbsp"
        case .teaspoons: return "tsp"
        case .grams: return "g"
        case .ounces: return "oz"
        case .pounds: return "lb"
        case .ml: return "ml"
        case .liters: return "l"
        case .pieces: return "pcs"
        case .pinch: return "pn"
        }
    }
    
    var singular: String {
        switch self {
        case .cups: return "cup"
        case .tablespoons: return "tablespoon"
        case .teaspoons: return "teaspoon"
        case .grams: return "gram"
        case .ounces: return "ounce"
        case .pounds: return "pound"
        case .ml: return "milliliter"
        case .liters: return "liter"
        case .pieces: return "piece"
        case .pinch: return "pinch"
        }
    }
    
    var plural: String {
        switch self {
        case .cups: return "cups"
        case .tablespoons: return "tablespoons"
        case .teaspoons: return "teaspoons"
        case .grams: return "grams"
        case .ounces: return "ounces"
        case .pounds: return "pounds"
        case .ml: return "milliliters"
        case .liters: return "liters"
        case .pieces: return "pieces"
        case .pinch: return "pinches"
        }
    }
}
