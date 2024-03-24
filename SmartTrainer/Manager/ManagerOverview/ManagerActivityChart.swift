//
//  ManagerActivityChart.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/03/2024.
//

import SwiftUI
import Charts

struct ManagerActivityChart: View {
    var data: [ChartPoint] = [
        .init(title: "Mar 1", value: 37),
        .init(title: "Mar 2", value: 72),
        .init(title: "Mar 3", value: 66),
        .init(title: "Mar 4", value: 49),
        .init(title: "Mar 5", value: 81),
    ]
    var body: some View {
        Chart {
            ForEach(data) { point in
                LineMark(x: .value("Day", point.title), y: .value("Value", point.value), series: .value("Series", "1"))
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(by: .value("Series", "1"))
                    .symbol(by: .value("Series", 1))
            }
        }
        .frame(height: 300)
    }
}

#Preview {
    ManagerActivityChart()
}
