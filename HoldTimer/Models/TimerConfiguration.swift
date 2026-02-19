//
//  TimerConfiguration.swift
//  HoldTimer
//
//  Created by sashank.yalamanchili on 19.02.26.
//

import Foundation

struct TimerConfiguration {
    var holdTime: Int = 15
    var numberOfSets: Int = 1
    var repeatSide: Bool = false
    var restTime: Int = 5

    var totalDuration: Int {
        let totalHolds = repeatSide ? numberOfSets * 2 : numberOfSets
        let totalRests = totalHolds - 1
        return 5 + (totalHolds * holdTime) + (totalRests * restTime)
    }

    var formattedTotalDuration: String {
        let minutes = totalDuration / 60
        let seconds = totalDuration % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
