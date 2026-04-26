//
//  FractionFormatter.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import Foundation

struct FractionFormatter {
    static func format(_ value: Double) -> String {
        guard value > 0 else { return "0" }
        
        let whole = Int(value)
        let frac = value - Double(whole)
        
        let fractionString: String? = {
            if frac < 0.0625 { return nil }
            if abs(frac - 0.125) < 0.03 { return "⅛" }
            if abs(frac - 0.25) < 0.05 { return "¼" }
            if abs(frac - 0.333) < 0.05 { return "⅓" }
            if abs(frac - 0.5) < 0.05 { return "½" }
            if abs(frac - 0.667) < 0.05 { return "⅔" }
            if abs(frac - 0.75) < 0.05 { return "¾" }
            return String(format: "%.1f", frac).replacingOccurrences(of: "0.", with: ".")
        }()
        
        if whole == 0, let f = fractionString { return f }
        if let f = fractionString { return "\(whole)\(f)" }
        return "\(whole)"
    }
}
