//
//  ContentView.swift
//  TimeProgress
//
//  Created by Zhengtao Gao on 17.02.2025.
//

import SwiftUI

struct ContentView: View {
    var yearPercentage: Double { DateUtils.calculateYearPercentage() }
    var monthPercentage: Double { DateUtils.calculateMonthPercentage() }
    var dayPercentage: Double { DateUtils.calculateDayPercentage() }

    // date formatter
    private let dayFormatter = DateUtils.getDateFormatter(format: "EEE, dd")
    private let monthFormatter = DateUtils.getDateFormatter(format: "MMM")
    private let yearFormatter = DateUtils.getDateFormatter(format: "yyyy")

    var body: some View {
        HStack {
            VStack {
                ProgressView(
                    "Progress of \(dayFormatter.string(from: Date()))",
                    value: dayPercentage, total: 100.0
                )
                .progressViewStyle(LinearProgressViewStyle())
                .padding()

                ProgressView(
                    "Progress of \(monthFormatter.string(from: Date()))", value: monthPercentage,
                    total: 100.0
                )
                .progressViewStyle(LinearProgressViewStyle())
                .padding()

                ProgressView(
                    "Progress of \(yearFormatter.string(from: Date()))", value: yearPercentage, total: 100.0
                )
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            }
            .frame(width: 300, height: 200)

            VStack(spacing: 20) {
                Text("Time Progress")
                    .font(.title)

                HStack {
                    VStack {
                        PieChart(percentage: dayPercentage, size: 120)
                        Text("Today")
                    }

                    VStack {
                        PieChart(percentage: monthPercentage, size: 120)
                        Text("This Month")
                    }

                    VStack {
                        PieChart(percentage: yearPercentage, size: 120)
                        Text("This Year")
                    }
                }
            }
            .frame(width: 400, height: 200)
            .padding(50)
        }
    }
}

#Preview {
    ContentView()
}
