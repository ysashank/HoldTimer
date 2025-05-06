//
//  TimePickerView.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 29.04.25.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var totalSeconds: Int

    @State private var minutes: Int = 0
    @State private var seconds: Int = 15 // default to 15s

    var body: some View {
        HStack {
            Picker("Minutes", selection: $minutes) {
                ForEach(0..<60) { minute in
                    Text("\(minute)").tag(minute)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 100)
            .clipped()
            
            Text("min")

            Picker("Seconds", selection: $seconds) {
                ForEach(0..<60) { second in
                    Text("\(second)").tag(second)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 100)
            .clipped()
            
            Text("sec")
        }
        .frame(height: 180)
        .onAppear {
            // Set initial picker values based on totalSeconds
            minutes = totalSeconds / 60
            seconds = totalSeconds % 60
        }
        .onChange(of: minutes) {
            updateTotal()
        }
        .onChange(of: seconds) {
            updateTotal()
        }
    }

    private func updateTotal() {
        totalSeconds = (minutes * 60) + seconds
        // Clamp to 1...3599 (1s to 59:59)
        totalSeconds = max(1, min(totalSeconds, 3599))
    }
}
