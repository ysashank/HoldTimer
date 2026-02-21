//
//  ActiveTimerView.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 19.02.26.
//

import SwiftUI

struct ActiveTimerView: View {
    var session: TimerSession

    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text(session.currentLabel)
                    .font(.title)
                    .foregroundColor(.foregroundSecondary)

                Text(session.formattedTimer)
                    .font(.system(size: 98, weight: .medium, design: .rounded))
                    .foregroundColor(
                        session.isPrepPhase ? .timerPrep :
                            (session.currentLabel == "Rest" ? .timerRest : .timerActive)
                    )
                    .frame(height: 120)
            }
            .padding(.top, 24)

            Spacer()

            Button {
                session.stopRoutine()
            } label: {
                Text("Stop")
                    .foregroundColor(.destructive)
                    .frame(width: 84, height: 84)
                    .overlay {
                        Circle()
                            .stroke(Color.destructive, lineWidth: 1)
                    }
            }
            .opacity(0.56)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundPrimary)
        .padding(.horizontal)
    }
}
