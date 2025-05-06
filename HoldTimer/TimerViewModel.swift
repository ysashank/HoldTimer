//
//  TimerViewModel.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 29.04.25.
//

import Foundation
import Combine
import UIKit

class TimerViewModel: ObservableObject {
    // MARK: - Published UI State
    @Published var holdTime: Int = 15
    @Published var numberOfSets: Int = 1
    @Published var repeatSide: Bool = false
    @Published var isRunning = false
    @Published var showTimerView = false
    @Published var formattedTimer: String = "00:00"
    @Published var currentLabel: String = "Hold"
    @Published var isPrepPhase: Bool = true
    @Published var restTime: Int = 5
    
    var totalDuration: Int {
        let perSide = holdTime + restTime
        let perSet = repeatSide ? 2 * perSide : perSide
        return 5 + numberOfSets * perSet
    }

    var formattedTotalDuration: String {
        let minutes = totalDuration / 60
        let seconds = totalDuration % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - Internal State
    private var timer: Timer?
    private var currentSeconds = 0
    private var currentSet = 1
    private var sideState: SideState = .left

    private enum SideState {
        case left, right
    }

    // MARK: - Timer Flow
    func startRoutine() {
        UIApplication.shared.isIdleTimerDisabled = true
        isRunning = true
        showTimerView = true
        currentSet = 1
        sideState = .left
        startPrep()
    }

    func stopRoutine() {
        UIApplication.shared.isIdleTimerDisabled = false
        timer?.invalidate()
        timer = nil
        isRunning = false
        showTimerView = false
        formattedTimer = "00:00"
    }

    // MARK: - Prep Phase
    private func startPrep() {
        currentLabel = "Get Ready"
        isPrepPhase = true
        runTimer(for: 5) { [weak self] in
            self?.startHold()
        }
    }

    // MARK: - Hold Phase
    private func startHold() {
        currentLabel = "Hold"
        isPrepPhase = false
        runTimer(for: holdTime) { [weak self] in
            self?.playEnd()
            self?.handlePostHold()
        }
    }

    private func handlePostHold() {
        if repeatSide {
            if sideState == .left {
                sideState = .right
                startRest()
            } else {
                sideState = .left
                currentSet += 1
                if currentSet > numberOfSets {
                    stopRoutine()
                } else {
                    startRest()
                }
            }
        } else {
            currentSet += 1
            if currentSet > numberOfSets {
                stopRoutine()
            } else {
                startRest()
            }
        }
    }

    // MARK: - Rest Phase
    private func startRest() {
        currentLabel = "Rest"
        runTimer(for: restTime) { [weak self] in
            self?.startHold()
        }
    }

    // MARK: - Timer Logic
    private func runTimer(for seconds: Int, completion: @escaping () -> Void) {
        timer?.invalidate()
        currentSeconds = seconds
        updateFormattedTimer()

        if currentLabel == "Hold" {
            playStart()
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] t in
            guard let self = self else { return }

            self.currentSeconds -= 1
            self.updateFormattedTimer()

            if self.currentSeconds == 0 {
                if self.currentLabel == "Hold" {
                    self.playEnd()
                }
                t.invalidate()
                completion()
            } else if self.currentSeconds <= 5 {
                SoundManager.shared.play(.warn)
            }
        }
    }

    private func updateFormattedTimer() {
        let minutes = currentSeconds / 60
        let seconds = currentSeconds % 60
        formattedTimer = String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - Sound Handling
    private func playStart() {
        SoundManager.shared.play(.start)
        SoundManager.shared.vibrate()
    }

    private func playEnd() {
        SoundManager.shared.play(.end)
        SoundManager.shared.vibrate()
    }
}
