//
//  StepDraftRow.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import SwiftUI

struct StepDraftRow: View {
    @Binding var draft: StepDraft
    let index: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(index + 1)")
                .font(.caption.weight(.bold))
                .frame(width: 28, height: 28)
                .background(Color.blue.opacity(0.15), in: Circle())
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading, spacing: 8) {
                TextField("Step Instructions", text: $draft.instruction, axis: .vertical)
                    .lineLimit(2...5)
                
                Stepper(
                    "Duration: \(draft.durationSeconds)s",
                    value: $draft.durationSeconds,
                    in: 0...600, step: 15
                )
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    @Previewable @State var draft = StepDraft()
    
    StepDraftRow(draft: $draft, index: 0)
}
