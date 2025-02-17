//
//  LinearProgress.swift
//  TimeProgress
//
//  Created by Zhengtao Gao on 17.02.2025.
//

import SwiftUI

struct LinearProgressView<Shape: SwiftUI.Shape>: View {
    var value: Double
    var shape: Shape

    var body: some View {
        shape.fill(Color.gray.opacity(0.3))
            .overlay(alignment: .leading) {
                GeometryReader { proxy in
                    shape.fill(.tint)
                        .frame(width: proxy.size.width * value)
                }
            }
            .clipShape(shape)
    }
}

struct LinearProgressRow: View {
    var title: String
    var progress: Double
    var color: Color

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
                .frame(width: 40, alignment: .leading)

            LinearProgressView(value: progress / 100.0, shape: Capsule())
                .tint(color)
                .frame(height: 8)

            Text("\(Int(progress))%")
                .font(.system(size: 14))
                .frame(width: 40, alignment: .trailing)
        }
        .padding([.top, .bottom], 10)
    }
}

#Preview {
    LinearProgressView(value: 0.6, shape: Capsule())
        .tint(Gradient(colors: [.purple, .blue]))
        .frame(width: 200, height: 20)
        .padding(10)
}

