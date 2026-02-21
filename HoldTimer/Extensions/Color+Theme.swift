//
//  Color+Theme.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 19.02.26.
//  Updated by sashank.yalamanchili on 21.02.26.
//

import SwiftUI
import UIKit

extension Color {
    static let backgroundPrimary = Color(UIColor.systemBackground)
    static let backgroundSecondary = Color(UIColor.secondarySystemBackground)
    static let backgroundTertiary = Color(UIColor.tertiarySystemBackground)

    static let foregroundPrimary = Color(UIColor.label)
    static let foregroundSecondary = Color(UIColor.secondaryLabel)
    static let foregroundTertiary = Color(UIColor.tertiaryLabel)

    static let timerActive = Color(UIColor(dynamicProvider: { t in
        t.userInterfaceStyle == .dark
            ? UIColor(red: 0.75, green: 0.80, blue: 0.85, alpha: 1)
            : UIColor(red: 0.20, green: 0.42, blue: 0.62, alpha: 1)
    }))
    static let timerRest = Color(UIColor(dynamicProvider: { t in
        t.userInterfaceStyle == .dark
            ? UIColor(red: 0.85, green: 0.82, blue: 0.75, alpha: 1)
            : UIColor(red: 0.55, green: 0.42, blue: 0.15, alpha: 1)
    }))
    static let timerPrep = Color(.systemRed)

    static let buttonSurface = Color(UIColor(dynamicProvider: { t in
        t.userInterfaceStyle == .dark
            ? UIColor(red: 0.25, green: 0.25, blue: 0.26, alpha: 1)
            : UIColor(red: 0.60, green: 0.60, blue: 0.62, alpha: 1)
    }))
    static let destructive = Color(.systemRed)

    static let divider = Color(UIColor.separator)
}
