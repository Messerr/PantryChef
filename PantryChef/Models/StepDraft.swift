//
//  StepDraft.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import Foundation
import SwiftData

@Observable
final class StepDraft {
    var id = UUID()
    var instruction: String
    var durationSeconds: Int
    
    init(
        id: UUID = UUID(),
        instruction: String = "",
        durationSeconds: Int = 0
    ) {
        self.id = id
        self.instruction = instruction
        self.durationSeconds = durationSeconds
    }
}
