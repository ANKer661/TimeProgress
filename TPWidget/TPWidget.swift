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
                PieChart(percentage: entry.dayPercentage, size: 80)
                    .frame(width: 80, height: 120)
                Text("Day")
                    .font(.system(size: 14))
            }
            .padding()

            VStack {
                PieChart(percentage: entry.monthPercentage, size: 80)
                    .frame(width: 80, height: 120)
                Text("Month")
                    .font(.system(size: 14))
            }
            .padding()

            VStack {
                PieChart(percentage: entry.yearPercentage, size: 80)
                    .frame(width: 80, height: 120)
                Text("Year")
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
                PieChart(
                    percentage: (100.0 - entry.dayPercentage), size: 80,
                    useBatteryStyle: true
                )
                .frame(width: 80, height: 120)
                Text("Day")
                    .font(.system(size: 14))
            }
            .padding()

            VStack {
                PieChart(
                    percentage: (100.0 - entry.monthPercentage), size: 80,
                    useBatteryStyle: true
                )
                .frame(width: 80, height: 120)
                Text("Month")
                    .font(.system(size: 14))
            }
            .padding()

            VStack {
                PieChart(
                    percentage: (100.0 - entry.yearPercentage), size: 80,
                    useBatteryStyle: true
                )
                .frame(width: 80, height: 120)
                Text("Year")
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
            PieChart(percentage: entry.yearPercentage, size: 110)
                .containerBackground(for: .widget) {
                    Color.clear
                }
                .frame(height: 130)
            Text("Year")
                .font(.system(size: 14))
        }
        .padding()
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
            PieChart(
                percentage: (100.0 - entry.yearPercentage), size: 110,
                useBatteryStyle: true
            )
            .containerBackground(for: .widget) {
                Color.clear
            }
            .frame(height: 130)
            Text("Year")
                .font(.system(size: 14))
        }
        .padding()
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
            PieChart(percentage: entry.monthPercentage, size: 110)
                .containerBackground(for: .widget) {
                    Color.clear
                }
                .frame(height: 130)
            Text("Month")
                .font(.system(size: 14))
        }
        .padding()
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
            PieChart(
                percentage: (100.0 - entry.monthPercentage), size: 110,
                useBatteryStyle: true
            )
            .containerBackground(for: .widget) {
                Color.clear
            }
            .frame(height: 130)
            Text("Month")
                .font(.system(size: 14))
        }
        .padding()
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
            PieChart(percentage: entry.dayPercentage, size: 110)
                .containerBackground(for: .widget) {
                    Color.clear
                }
                .frame(height: 130)
            Text("Day")
                .font(.system(size: 14))
        }
        .padding()
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
            PieChart(
                percentage: (100.0 - entry.dayPercentage), size: 110,
                useBatteryStyle: true
            )
            .containerBackground(for: .widget) {
                Color.clear
            }
            .frame(height: 130)
            Text("Day")
                .font(.system(size: 14))
        }
        .padding()
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

struct LinearProgressWidgetView: View {
    private let dayFormatter = DateUtils.getDateFormatter(format: "EEE")
    private let monthFormatter = DateUtils.getDateFormatter(format: "MMM")
    private let yearFormatter = DateUtils.getDateFormatter(format: "yyyy")

    var entry: TimeProgressProvider.Entry

    var body: some View {
        VStack {
            LinearProgressRow(
                title: dayFormatter.string(from: Date()),
                progress: entry.dayPercentage,
                color: progressColor(for: entry.dayPercentage)
            )

            LinearProgressRow(
                title: monthFormatter.string(from: Date()),
                progress: entry.monthPercentage,
                color: progressColor(for: entry.monthPercentage)
            )

            LinearProgressRow(
                title: yearFormatter.string(from: Date()),
                progress: entry.yearPercentage,
                color: progressColor(for: entry.yearPercentage)
            )
        }
        .padding()
        .containerBackground(for: .widget) {
            Color.clear
        }
    }

    private func progressColor(for progress: Double) -> Color {
        switch progress {
        case 0..<80:
            return .green
        case 80..<90:
            return .yellow
        default:
            return .blue
        }
    }
}
