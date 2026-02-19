//
//  ScreenManager.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 19.02.26.
//

import UIKit

enum ScreenManager {
    static func disableScreenSleep() {
        UIApplication.shared.isIdleTimerDisabled = true
    }

    static func enableScreenSleep() {
        UIApplication.shared.isIdleTimerDisabled = false
    }

    @discardableResult
    static func observeBackgroundEntry(handler: @escaping () -> Void) -> any NSObjectProtocol {
        NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: nil,
            queue: .main
        ) { _ in handler() }
    }

    static func removeBackgroundObserver(_ token: any NSObjectProtocol) {
        NotificationCenter.default.removeObserver(token)
    }
}
