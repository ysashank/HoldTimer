//
//  ContentView.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 29.04.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TimerViewModel()

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {

                if viewModel.showTimerView {
                    VStack(spacing: 8) {
                        Text(viewModel.currentLabel)
                            .font(.title)
                            .foregroundColor(.secondary)

                        Text(viewModel.formattedTimer)
                            .font(.system(size: 98, weight: .medium, design: .rounded))
                            .foregroundColor(
                                viewModel.isPrepPhase ? .red :
                                (viewModel.currentLabel == "Rest" ? .yellow : .primary)
                            )
                            .frame(height: 120)
                            .padding(.top, 8)
                    }
                } else {
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Hold Timer")
                                .font(.largeTitle)
                            TimePickerView(totalSeconds: $viewModel.holdTime)
                                .frame(height: 180)
                            
                            Stepper(value: $viewModel.numberOfSets, in: 1...9) {
                                Text("Sets: \(viewModel.numberOfSets)")
                            }
                            .padding(.top)
                            
                            if viewModel.numberOfSets > 1 {
                                Text("Rest Between Sets")
                                TimePickerView(totalSeconds: $viewModel.restTime)
                                    .frame(height: 180)
                            }

                            HStack {
                                Toggle(isOn: $viewModel.repeatSide) {
                                    Text("Repeat on Both Sides")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            
                            HStack {
                                Text("Total Duration: ")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(viewModel.formattedTotalDuration)")
                                    .fontWeight(.bold)
                                    
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }

            Spacer()

            Button(action: {
                if viewModel.isRunning {
                    viewModel.stopRoutine()
                } else {
                    viewModel.startRoutine()
                }
            }) {
                Text(viewModel.isRunning ? "Stop" : "Start")
                    .foregroundColor(viewModel.isRunning ? Color.red.opacity(0.7) : Color.primary.opacity(0.7))
                    .padding(.vertical, 14)
                    .padding(.horizontal, 48)
                    .background(
                        Group {
                            if viewModel.isRunning {
                                Color.clear
                            } else {
                                Capsule().fill(Color.primary.opacity(0.1))
                            }
                        }
                    )
                    .overlay(viewModel.isRunning ?
                        RoundedRectangle(cornerRadius: 21).stroke(Color.red.opacity(0.7), lineWidth: 1)
                        : nil
                    )
            }
            .padding(.bottom, 77)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
