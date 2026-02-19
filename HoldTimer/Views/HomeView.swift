//
//  HomeView.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 29.04.25.
//  Updated by sashank.yalamanchili on 19.02.26.
//

import SwiftUI

struct HomeView: View {
    @State private var session = TimerSession()

    var body: some View {
        @Bindable var session = session
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 24) {
                        TimePickerView(totalSeconds: $session.config.holdTime)
                            .frame(height: 180)

                        Stepper("Sets: \(session.config.numberOfSets)", value: $session.config.numberOfSets, in: 1...9)
                            .padding(.horizontal)

                        if session.config.numberOfSets > 1 {
                            VStack(spacing: 8) {
                                Text("Rest Between Sets")
                                    .font(.body.weight(.semibold))
                                    .foregroundStyle(.primary)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top, 8)

                                TimePickerView(totalSeconds: $session.config.restTime)
                                    .frame(height: 180)
                            }
                        }

                        Toggle("Repeat on Both Sides", isOn: $session.config.repeatSide)
                            .padding(.horizontal)

                        HStack {
                            Text("Total Duration")
                            Spacer()
                            Text(session.config.formattedTotalDuration)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }

                Button {
                    session.startRoutine()
                } label: {
                    Text("Start")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.primary.opacity(0.1))
                        .foregroundStyle(.primary)
                        .clipShape(.rect(cornerRadius: 12))
                }
                .padding()
            }
            .navigationTitle("Hold Timer")
            .navigationBarTitleDisplayMode(.large)
            .background(.background)
            .padding(.horizontal)
            .fullScreenCover(isPresented: $session.isRunning) {
                ActiveTimerView(session: session)
            }
        }
    }
}

#Preview {
    HomeView()
}
