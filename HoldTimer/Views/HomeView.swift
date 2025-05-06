//
//  ContentView.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 29.04.25.
//

#Preview {
    HomeView()
}

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
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
                    }
                    .padding(.top, 24)
                } else {
                    ScrollView {
                        VStack(spacing: 24) {
                            TimePickerView(totalSeconds: $viewModel.holdTime)
                                .frame(height: 180)
                            
                            Stepper("Sets: \(viewModel.numberOfSets)", value: $viewModel.numberOfSets, in: 1...9)
                                .padding(.horizontal)
                            
                            if viewModel.numberOfSets > 1 {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Rest Between Sets")
                                        .font(.body.weight(.semibold))
                                        .foregroundColor(.primary)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.top, 8)
                                    
                                    TimePickerView(totalSeconds: $viewModel.restTime)
                                        .frame(height: 180)
                                }
                            }
                            
                            Toggle("Repeat on Both Sides", isOn: $viewModel.repeatSide)
                                .padding(.horizontal)
                            
                            HStack {
                                Text("Total Duration")
                                Spacer()
                                Text(viewModel.formattedTotalDuration)
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top)
                    }
                }
                
                ZStack {
                    if viewModel.isRunning {
                        Button(action: {
                            viewModel.stopRoutine()
                        }) {
                            Text("Stop")
                                .foregroundColor(.red)
                                .frame(width: 84, height: 84)
                                .overlay(
                                    Circle()
                                        .stroke(Color.red, lineWidth: 1)
                                )
                        }
                        .opacity(0.56)
                    } else {
                        Button(action: {
                            viewModel.startRoutine()
                        }) {
                            Text("Start")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.primary.opacity(0.1))
                                .foregroundColor(.primary)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(viewModel.isRunning ? "" : "Hold Timer")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemBackground))
        }
    }
}
