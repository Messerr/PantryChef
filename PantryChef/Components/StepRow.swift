//
//  StepRow.swift
//  PantryChef
//
//  Created by David Messer on 4/23/26.
//

import SwiftUI

struct StepRow: View {
    var step: Step
    var sortIndex: Int {
        return step.sortIndex + 1
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(String(sortIndex))
                .font(.caption.weight(.bold))
                .frame(width: 28, height: 28)
                .background(Color.blue.opacity(0.15), in: Circle())
                .foregroundStyle(.blue)
            
            Text(step.instruction)
                .font(.subheadline)
            
            Spacer()
            
            if let seconds = step.durationSeconds {
                HStack {
                    Label("\(seconds / 60) min", systemImage: "clock")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
            }
        }
        .padding()
    }
}

#Preview {
    StepRow(
        step: Step(
            instruction: "Stir hard",
            durationSeconds: 60,
            sortIndex: 0,
        )
    )
}
