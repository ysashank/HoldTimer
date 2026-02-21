//
//  TimerSession.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 19.02.26.
//

import Foundation
import Observation

@MainActor
@Observable
class TimerSession {
    var config = TimerConfiguration()
    var isRunning = false
    var formattedTimer: String { String(format: "%02d:%02d", currentSeconds / 60, currentSeconds % 60) }
    var currentLabel: String { phase.label(sideState: sideState, repeatSide: config.repeatSide) }
    var isPrepPhase: Bool { phase == .prep }
    var isRestPhase: Bool { phase == .rest }

    private enum Phase {
        case prep, hold, rest

        func label(sideState: SideState, repeatSide: Bool) -> String {
            switch self {
            case .prep: "Get Ready"
            case .hold: repeatSide ? (sideState == .left ? "Hold Left Side" : "Hold Right Side") : "Hold"
            case .rest: "Rest"
            }
        }
    }

    private enum SideState { case left, right }

    private var phase: Phase = .prep
    private var timer: Timer?
    private var currentSeconds = 0
    private var currentSet = 1
    private var sideState: SideState = .left
    private var backgroundObserverToken: (any NSObjectProtocol)?

    func startRoutine() {
        ScreenManager.disableScreenSleep()
        isRunning = true
        currentSet = 1
        sideState = .left
        startPrep()
        backgroundObserverToken = ScreenManager.observeBackgroundEntry { [weak self] in
            self?.stopRoutine()
        }
    }

    func stopRoutine() {
        ScreenManager.enableScreenSleep()
        timer?.invalidate()
        timer = nil
        isRunning = false
        currentSeconds = 0
        if let token = backgroundObserverToken {
            ScreenManager.removeBackgroundObserver(token)
            backgroundObserverToken = nil
        }
    }

    private func startPrep() {
        phase = .prep
        runTimer(for: 5) { [weak self] in self?.startHold() }
    }

    private func startHold() {
        phase = .hold
        runTimer(for: config.holdTime) { [weak self] in self?.handlePostHold() }
    }

    private func handlePostHold() {
        if config.repeatSide {
            if sideState == .left {
                sideState = .right
                startRest()
            } else {
                sideState = .left
                currentSet += 1
                if currentSet > config.numberOfSets { stopRoutine() } else { startRest() }
            }
        } else {
            currentSet += 1
            if currentSet > config.numberOfSets { stopRoutine() } else { startRest() }
        }
    }

    private func startRest() {
        phase = .rest
        runTimer(for: config.restTime) { [weak self] in self?.startHold() }
    }

    private func runTimer(for seconds: Int, completion: @escaping () -> Void) {
        timer?.invalidate()
        currentSeconds = seconds
        if phase == .hold { playStart() }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] t in
            Task { @MainActor [weak self] in
                guard let self else { return }
                self.currentSeconds -= 1
                if self.currentSeconds == 0 {
                    if self.phase == .hold { self.playEnd() }
                    t.invalidate()
                    completion()
                } else if self.currentSeconds <= 5 {
                    SoundManager.shared.play(.warn)
                }
            }
        }
    }

    private func playStart() {
        SoundManager.shared.play(.start)
        SoundManager.shared.vibrate()
    }

    private func playEnd() {
        SoundManager.shared.play(.end)
        SoundManager.shared.vibrateDouble()
    }
}
