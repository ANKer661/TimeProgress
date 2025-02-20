//
//  CircleProgress.swift
//  TimeProgress
//
//  Created by Zhengtao Gao on 17.02.2025.
//

import SwiftUI

struct CircleProgressView: View {
    let value: Double  // 0.0 ~ 1.0
    let color: Color
    let size: CGFloat
    let lineWidth: CGFloat

    var body: some View {
        ZStack {
            // background circle
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(Color.gray)
                .opacity(0.3)

            // progress circle
            Circle()
                .trim(from: 0.0, to: CGFloat(value))
                .stroke(
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .foregroundColor(color)
                .rotationEffect(.degrees(-90))  // start at the top

            // percentage text
            Text("\(Int(value * 100))%")
                .font(.system(size: size * 0.2))
                .foregroundColor(.primary)
        }
        .frame(width: size, height: size)
        .padding()
    }
}

#Preview {
    HStack {
        CircleProgressView(value: 0.2, color: .green, size: 100, lineWidth: 10)
        CircleProgressView(value: 0.8, color: .pink, size: 100, lineWidth: 10)
        CircleProgressView(value: 0.95, color: .blue, size: 100, lineWidth: 10)
    }
}
