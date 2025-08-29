//
//  SoundManager.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 29.04.25.
//

import AVFoundation
import UIKit

class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    private let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)

    init() {
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
    }

    func play(_ type: SoundType) {
        guard let url = Bundle.main.url(forResource: type.rawValue, withExtension: "wav") else {
            print("Missing sound file: \(type.rawValue).wav")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Sound playback error: \(error)")
        }
    }
    
    func stop() {
        player?.stop()
    }
    
    func vibrate() {
#if os(iOS)
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
#endif
    }
    
    func vibrateDouble() {
#if os(iOS)
        impactFeedback.prepare()
        
        // Double tap pattern for end of hold
        impactFeedback.impactOccurred()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
            self?.impactFeedback.impactOccurred()
        }
#endif
    }

    enum SoundType: String {
        case start
        case warn
        case end
    }
}

extension UIDevice {
    var hasHapticFeedback: Bool {
        if #available(iOS 13.0, *) {
            return true
        }
        return false
    }
}
