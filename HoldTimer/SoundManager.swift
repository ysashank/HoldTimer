//
//  SoundManager.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 29.04.25.
//

import AVFoundation
import UIKit

final class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    private let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)

    private init() {
        configureAudioSession()
    }

    private func configureAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    func play(_ type: SoundType) {
        guard let url = Bundle.main.url(forResource: type.rawValue, withExtension: "wav"),
              let p = try? AVAudioPlayer(contentsOf: url) else { return }
        player = p
        player?.play()
    }

    @MainActor func vibrate() {
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
    }

    @MainActor func vibrateDouble() {
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(0.15))
            impactFeedback.impactOccurred()
        }
    }

    enum SoundType: String {
        case start
        case warn
        case end
    }
}
