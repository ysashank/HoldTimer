//
//  Color+Theme.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 19.02.26.
//

import SwiftUI

extension Color {
    // MARK: - Background Layers

    static let backgroundPrimary = Color.black
    static let backgroundSecondary = Color(red: 0.18, green: 0.18, blue: 0.19)
    static let backgroundTertiary = Color(red: 0.22, green: 0.22, blue: 0.23)

    // MARK: - Foreground Text

    static let foregroundPrimary = Color(red: 0.92, green: 0.92, blue: 0.93)
    static let foregroundSecondary = Color(red: 0.65, green: 0.65, blue: 0.67)
    static let foregroundTertiary = Color(red: 0.48, green: 0.48, blue: 0.50)

    // MARK: - Timer States

    static let timerActive = Color(red: 0.75, green: 0.80, blue: 0.85)
    static let timerRest = Color(red: 0.85, green: 0.82, blue: 0.75)
    static let timerPrep = Color(red: 0.70, green: 0.45, blue: 0.45)

    // MARK: - Interactive Elements

    static let buttonSurface = Color(red: 0.25, green: 0.25, blue: 0.26)
    static let destructive = Color(red: 0.70, green: 0.45, blue: 0.45)

    // MARK: - Dividers

    static let divider = Color(red: 0.28, green: 0.28, blue: 0.29)
}
