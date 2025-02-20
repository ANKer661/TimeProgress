//
//  TPWidgetBundle.swift
//  TPWidget
//
//  Created by Zhengtao Gao on 17.02.2025.
//

import SwiftUI
import WidgetKit

@main
struct TPWidgetBundle: WidgetBundle {
    var body: some Widget {
        DayProgressWidget()
        MonthProgressWidget()
        YearProgressWidget()
        DayBatteryWidget()
        MonthBatteryWidget()
        YearBatteryWidget()
        TimeProgressWidget()
        TimeBatteryWidget()
        LinearProgressWidget()
    }
}
