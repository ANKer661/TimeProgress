//
//  TPWidget.swift
//  TPWidget
//
//  Created by Zhengtao Gao on 17.02.2025.
//

import SwiftUI
import WidgetKit

struct TimeProgressWidgetEntry: TimelineEntry {
    let date: Date
    let dayPercentage: Double  // 0 ~ 100
    let monthPercentage: Double
    let yearPercentage: Double
}

struct TimeProgressProvider: TimelineProvider {
    func placeholder(in context: Context) -> TimeProgressWidgetEntry {
        TimeProgressWidgetEntry(
            date: Date(), dayPercentage: 50, monthPercentage: 85,
            yearPercentage: 92)
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (TimeProgressWidgetEntry) -> Void
    ) {
        let entry = TimeProgressWidgetEntry(
            date: Date(), dayPercentage: 50, monthPercentage: 85,
            yearPercentage: 92)
        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<TimeProgressWidgetEntry>) -> Void
    ) {
        let currentDate = Date()
        let entry = TimeProgressWidgetEntry(
            date: currentDate,
            dayPercentage: DateUtils.calculateDayPercentage(),
            monthPercentage: DateUtils.calculateMonthPercentage(),
            yearPercentage: DateUtils.calculateYearPercentage()
        )
        let nextUpdate = Calendar.current.date(
            byAdding: .minute, value: 15, to: currentDate)!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))

        WidgetCenter.shared.reloadAllTimelines()
        completion(timeline)
    }
}

struct TimeProgressWidget: Widget {
    let kind: String = "TimeProgressWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeProgressProvider()) {
            entry in
            TimeProgressWidgetView(entry: entry)
        }
        .configurationDisplayName("Time Progress")
        .description("Display the progress of the year, month and day.")
        .supportedFamilies([.systemMedium])
    }
}

struct TimeProgressWidgetView: View {
    var entry: TimeProgressProvider.Entry

    var body: some View {
        HStack(spacing: 5) {
            VStack {
                CircleProgressView(
                    value: entry.dayPercentage / 100,
                    color: getProgressColor(for: entry.dayPercentage), size: 80,
                    lineWidth: 10
                )
                .frame(width: 80, height: 120)
                Text(DateUtils.dayFormatter.string(from: Date()))
                    .font(.system(size: 14))
            }
            .padding()

            VStack {
                CircleProgressView(
                    value: entry.monthPercentage / 100,
                    color: getProgressColor(for: entry.monthPercentage),
                    size: 80,
                    lineWidth: 10
                )
                .frame(width: 80, height: 120)
                Text(DateUtils.monthFormatter.string(from: Date()))
                    .font(.system(size: 14))
            }
            .padding()

            VStack {
                CircleProgressView(
                    value: entry.yearPercentage / 100,
                    color: getProgressColor(for: entry.yearPercentage),
                    size: 80,
                    lineWidth: 10
                )
                .frame(width: 80, height: 120)
                Text(DateUtils.yearFormatter.string(from: Date()))
                    .font(.system(size: 14))
            }
            .padding()
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct TimeBatteryWidget: Widget {
    let kind: String = "TimeBatteryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeProgressProvider()) {
            entry in
            TimeBatteryWidgetView(entry: entry)
        }
        .configurationDisplayName("Time Battery")
        .description("Display the remaining time in battery-like style.")
        .supportedFamilies([.systemMedium])
    }
}

struct TimeBatteryWidgetView: View {
    var entry: TimeProgressProvider.Entry

    var body: some View {
        HStack(spacing: 5) {
            VStack {
                CircleProgressView(
                    value: 1 - entry.dayPercentage / 100,
                    color: getProgressColor(
                        for: entry.dayPercentage, useBatteryStyle: true),
                    size: 80,
                    lineWidth: 10
                )
                .frame(width: 80, height: 120)
                Text(DateUtils.dayFormatter.string(from: Date()))
                    .font(.system(size: 14))
            }
            .padding()

            VStack {
                CircleProgressView(
                    value: 1 - entry.monthPercentage / 100,
                    color: getProgressColor(
                        for: entry.monthPercentage, useBatteryStyle: true),
                    size: 80,
                    lineWidth: 10
                )
                .frame(width: 80, height: 120)
                Text(DateUtils.monthFormatter.string(from: Date()))
                    .font(.system(size: 14))
            }
            .padding()

            VStack {
                CircleProgressView(
                    value: 1 - entry.yearPercentage / 100,
                    color: getProgressColor(
                        for: entry.yearPercentage, useBatteryStyle: true),
                    size: 80,
                    lineWidth: 10
                )
                .frame(width: 80, height: 120)
                Text(DateUtils.yearFormatter.string(from: Date()))
                    .font(.system(size: 14))
            }
            .padding()
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct YearProgressWidget: Widget {
    let kind: String = "YearProgressWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeProgressProvider()) {
            entry in
            YearProgressWidgetView(entry: entry)
        }
        .configurationDisplayName("Year Progress")
        .description("Display the progress of the year.")
        .supportedFamilies([.systemSmall])
    }
}

struct YearProgressWidgetView: View {
    var entry: TimeProgressProvider.Entry

    var body: some View {
        VStack {
            CircleProgressView(
                value: entry.yearPercentage / 100,
                color: getProgressColor(for: entry.yearPercentage), size: 110,
                lineWidth: 10
            )
            .frame(height: 130)
            Text(DateUtils.yearFormatter.string(from: Date()))
                .font(.system(size: 14))
        }
        .padding()
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct YearBatteryWidget: Widget {
    let kind: String = "YearBatteryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeProgressProvider()) {
            entry in
            YearBatteryWidgetView(entry: entry)
        }
        .configurationDisplayName("Year Battery")
        .description(
            "Display the remaining time of the year in battery-like style."
        )
        .supportedFamilies([.systemSmall])
    }
}

struct YearBatteryWidgetView: View {
    var entry: TimeProgressProvider.Entry

    var body: some View {
        VStack {
            CircleProgressView(
                value: 1 - entry.yearPercentage / 100,
                color: getProgressColor(
                    for: entry.yearPercentage, useBatteryStyle: true),
                size: 110,
                lineWidth: 10
            )
            .frame(height: 130)
            Text(DateUtils.yearFormatter.string(from: Date()))
                .font(.system(size: 14))
        }
        .padding()
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct MonthProgressWidget: Widget {
    let kind: String = "MonthProgressWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeProgressProvider()) {
            entry in
            MonthProgressWidgetView(entry: entry)
        }
        .configurationDisplayName("Month Progress")
        .description("Display the progress of the month.")
        .supportedFamilies([.systemSmall])
    }
}

struct MonthProgressWidgetView: View {
    var entry: TimeProgressProvider.Entry

    var body: some View {
        VStack {
            CircleProgressView(
                value: entry.monthPercentage / 100,
                color: getProgressColor(for: entry.monthPercentage), size: 110,
                lineWidth: 10
            )
            .frame(height: 130)
            Text(DateUtils.monthFormatter.string(from: Date()))
                .font(.system(size: 14))
        }
        .padding()
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct MonthBatteryWidget: Widget {
    let kind: String = "MonthBatteryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeProgressProvider()) {
            entry in
            MonthBatteryWidgetView(entry: entry)
        }
        .configurationDisplayName("Month Battery")
        .description(
            "Display the remaining time of the month in battery-like style."
        )
        .supportedFamilies([.systemSmall])
    }
}

struct MonthBatteryWidgetView: View {
    var entry: TimeProgressProvider.Entry

    var body: some View {
        VStack {
            CircleProgressView(
                value: 1 - entry.monthPercentage / 100,
                color: getProgressColor(
                    for: entry.monthPercentage, useBatteryStyle: true),
                size: 110,
                lineWidth: 10
            )
            .frame(height: 130)
            Text(DateUtils.monthFormatter.string(from: Date()))
                .font(.system(size: 14))
        }
        .padding()
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct DayProgressWidget: Widget {
    let kind: String = "DayProgressWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeProgressProvider()) {
            entry in
            DayProgressWidgetView(entry: entry)
        }
        .configurationDisplayName("Day Progress")
        .description("Display the progress of the day.")
        .supportedFamilies([.systemSmall])
    }
}

struct DayProgressWidgetView: View {
    var entry: TimeProgressProvider.Entry

    var body: some View {
        VStack {
            CircleProgressView(
                value: entry.dayPercentage / 100,
                color: getProgressColor(for: entry.dayPercentage), size: 110,
                lineWidth: 10
            )
            .frame(height: 130)
            Text(DateUtils.dayFormatter.string(from: Date()))
                .font(.system(size: 14))
        }
        .padding()
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct DayBatteryWidget: Widget {
    let kind: String = "DayBatteryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeProgressProvider()) {
            entry in
            DayBatteryWidgetView(entry: entry)
        }
        .configurationDisplayName("Day Battery")
        .description(
            "Display the remaining time of the day in battery-like style."
        )
        .supportedFamilies([.systemSmall])
    }
}

struct DayBatteryWidgetView: View {
    var entry: TimeProgressProvider.Entry

    var body: some View {
        VStack {
            CircleProgressView(
                value: 1 - entry.dayPercentage / 100,
                color: getProgressColor(
                    for: entry.dayPercentage, useBatteryStyle: true), size: 110,
                lineWidth: 10
            )
            .frame(height: 130)
            Text(DateUtils.dayFormatter.string(from: Date()))
                .font(.system(size: 14))
        }
        .padding()
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct LinearProgressWidget: Widget {
    let kind: String = "LinearProgressWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeProgressProvider()) {
            entry in
            LinearProgressWidgetView(entry: entry)
        }
        .configurationDisplayName("Linear Progress")
        .description("Display the progress of the time in a linear style.")
        .supportedFamilies([.systemMedium])
    }
}

struct LinearProgressRow: View {
    var title: String
    var progress: Double
    var color: Color

    var body: some View {
     
        HStack {
            // date information
            Text(title)
                .font(.system(size: 14))
                .frame(width: 40, alignment: .leading)

            // linear progress
            LinearProgressView(value: progress / 100.0, shape: Capsule())
                .tint(color)
                .frame(height: 8)

            // percentage text
            Text("\(Int(progress))%")
                .font(.system(size: 14))
                .frame(width: 40, alignment: .trailing)
        }
        .padding([.top, .bottom], 10)
    }
}

struct LinearProgressWidgetView: View {
    private let dayFormatter = DateUtils.getDateFormatter(format: "EEE")

    var entry: TimeProgressProvider.Entry

    var body: some View {
        VStack {
            LinearProgressRow(
                title: dayFormatter.string(from: Date()),
                progress: entry.dayPercentage,
                color: getProgressColor(for: entry.dayPercentage)
            )

            LinearProgressRow(
                title: DateUtils.monthFormatter.string(from: Date()),
                progress: entry.monthPercentage,
                color: getProgressColor(for: entry.monthPercentage)
            )

            LinearProgressRow(
                title: DateUtils.yearFormatter.string(from: Date()),
                progress: entry.yearPercentage,
                color: getProgressColor(for: entry.yearPercentage)
            )
        }
        .padding()
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

func getProgressColor(for percentage: Double, useBatteryStyle: Bool = false)
    -> Color
{
    if useBatteryStyle {
        switch percentage {
        case 0..<80:
            return .green
        case 80..<90:
            return .yellow
        default:
            return .red
        }
    } else {
        switch percentage {
        case 0.0..<80:
            return .green
        case 80..<90:
            return .blue
        default:
            return Color(red: 0.9, green: 0.6, blue: 0.8)  // pink
        }
    }
}
