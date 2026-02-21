//
//  ActiveTimerView.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 19.02.26.
//  Updated by sashank.yalamanchili on 21.02.26.
//

import SwiftUI

struct ActiveTimerView: View {
    var session: TimerSession

    var body: some View {
        ZStack {
            Color.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {
                Text(session.currentLabel)
                    .font(.title3)
                    .foregroundColor(.foregroundSecondary)
                    .padding(.top, 24)

                Spacer()

                Text(session.formattedTimer)
                    .font(.system(size: 96, weight: .bold, design: .rounded))
                    .foregroundColor(timerColor)

                Spacer()

                Button {
                    session.stopRoutine()
                } label: {
                    Text("Stop")
                        .font(.title3)
                        .foregroundColor(.foregroundTertiary)
                        .padding(.horizontal, 80)
                        .padding(.vertical, 32)
                        .background(
                            Capsule()
                                .fill(Color.buttonSurface.opacity(0.16))
                        )
                }
                .padding(.bottom, 40)
            }
            .padding()
        }
    }

    private var timerColor: Color {
        session.isPrepPhase ? .timerPrep :
            (session.currentLabel == "Rest" ? .timerRest : .timerActive)
    }
}
