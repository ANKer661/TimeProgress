//
//  DateUtils.swift
//  TimeProgress
//
//  Created by Zhengtao Gao on 17.02.2025.
//

import Foundation

struct DateUtils {
    static private var formatterCache = [String: DateFormatter]()
    
    static func calculateYearPercentage() -> Double {
        let calendar = Calendar.current
        let today = Date()

        guard
            let startOfYear = calendar.date(
                from: calendar.dateComponents([.year], from: today)
            ),
            let endOfYear = calendar.date(
                byAdding: .year, value: 1, to: startOfYear
            )
        else {
            return 0
        }

        let totalDays =
            calendar.dateComponents(
                [.day], from: startOfYear, to: endOfYear
            ).day ?? 365
        let passedDays =
            calendar.dateComponents(
                [.day], from: startOfYear, to: today
            ).day ?? 0

        return Double(passedDays) / Double(totalDays) * 100
    }

    static func calculateMonthPercentage() -> Double {
        let calendar = Calendar.current
        let today = Date()

        guard
            let range = calendar.range(of: .day, in: .month, for: today),
            let startOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: today))
        else {
            return 0.0
        }

        let totalDays = range.count
        let passedDays =
            calendar.dateComponents([.day], from: startOfMonth, to: today).day
            ?? 0

        return Double(passedDays) / Double(totalDays) * 100
    }

    static func calculateDayPercentage() -> Double {
        let calendar = Calendar.current
        let now = Date()

        let startOfDay = calendar.startOfDay(for: now)
        guard
            let endOfDay = calendar.date(
                byAdding: .day, value: 1, to: startOfDay)
        else {
            return 0.0
        }

        let totalMinutesInADay =
            calendar.dateComponents([.minute], from: startOfDay, to: endOfDay)
            .minute ?? 1440
        let passedMinutes =
            calendar.dateComponents([.minute], from: startOfDay, to: now).minute
            ?? 0

        return Double(passedMinutes) / Double(totalMinutesInADay) * 100
    }
    
    static func getDateFormatter(format: String) -> DateFormatter {
        assert(!format.isEmpty, "Format string must not be empty")
        
        if let cachedFormatter = formatterCache[format] {
            return cachedFormatter
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatterCache[format] = formatter
        return formatter
    }
}
