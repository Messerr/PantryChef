//
//  CookingTimerView.swift
//  PantryChef
//
//  Created by David Messer on 4/25/26.
//

import SwiftUI

struct CookingTimerView: View {
    let totalSeconds: Int
    @State private var remaining: Int
    @State private var isRunning = false
    @State private var timer: Timer?
    
    init(totalSeconds: Int) {
        self.totalSeconds = totalSeconds
        self._remaining = State(initialValue: totalSeconds)
    }
    
    var progress: Double {
        1.0 - (Double(remaining) / Double(totalSeconds))
    }
    
    var timeString: String {
        let min = remaining / 60
        let sec = remaining % 60
        return String(format: "%d:%02d", min, sec)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(lineWidth: 8)
                    .opacity(0.15)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: progress)
                Text(timeString)
                    .font(.system(.title, design: .monospaced, weight: .bold))
            }
            .frame(width: 150, height: 150)
            
            HStack(spacing: 16) {
                Button(isRunning ? "Pause" : "Start") {
                    toggleTimer()
                }
                Button("Reset") {
                    resetTimer()
                }
            }
        }
    }
    
    func toggleTimer() {
        if isRunning {
            timer?.invalidate()
            timer = nil
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if remaining > 0 {
                    remaining -= 1
                } else {
                    timer?.invalidate()
                    timer = nil
                    isRunning = false
                }
            }
        }
        isRunning.toggle()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        remaining = totalSeconds
    }
}

#Preview {
    CookingTimerView(
        totalSeconds: 60
    )
}
