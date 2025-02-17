//
//  PieChart.swift
//  TimeProgress
//
//  Created by Zhengtao Gao on 17.02.2025.
//

import SwiftUI

struct PieChart: View {
    let percentage: Double  // 0.0 ~ 100.0
    let size: CGFloat
    let useBatteryStyle: Bool

    init(percentage: Double, size: CGFloat, useBatteryStyle: Bool = false) {
        self.percentage = percentage
        self.size = size
        self.useBatteryStyle = useBatteryStyle
    }

    var color: Color {
        if useBatteryStyle {
            switch percentage {
            case 0.0..<10.0:
                return .yellow
            case 10.0..<20.0:
                return .blue
            default:
                return .green
            }
        } else {
            switch percentage {
            case 0.0..<80.0:
                return .green
            case 80.0..<90.0:
                return .blue
            default:
                return Color(red: 0.9, green: 0.6, blue: 0.8)  // pink
            }
        }
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(Color.gray)
                .opacity(0.3)

            Circle()
                .trim(from: 0.0, to: CGFloat(percentage / 100))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(color)
                .rotationEffect(.degrees(-90))  // start at the top

            Text("\(Int(percentage))%")
                .font(.title)
                .foregroundColor(.primary)
        }
        .frame(width: size, height: size)
        .padding()
    }
}

#Preview {
    HStack {
        PieChart(percentage: 20.0, size: 100)
        PieChart(percentage: 85.0, size: 100)
        PieChart(percentage: 95.0, size: 100)
    }
    HStack {
        PieChart(percentage: 60.0, size: 100, useBatteryStyle: true)
        PieChart(percentage: 15.0, size: 100, useBatteryStyle: true)
        PieChart(percentage: 8.0, size: 100, useBatteryStyle: true)
    }
}
