//
//  AIScoresChartView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 03/03/2024.
//

import SwiftUI
import Charts

struct CoachScoresChartView: View {
    var rangeData: ChartPoint = .init(title: "Range", value: 3.8)
    var controlData: ChartPoint = .init(title: "Control", value: 4.1)
    var formData: ChartPoint = .init(title: "Form", value: 3.6)
    var body: some View {
        Chart {
            BarMark(x: .value("Range", rangeData.title), y: .value("Average Score", rangeData.value))
                .interpolationMethod(.catmullRom)
                .foregroundStyle(by: .value("Metric", "Range"))
                .symbol(by: .value("Metric", "Range"))
            BarMark(x: .value("Control", controlData.title), y: .value("Average Score", controlData.value))
                .interpolationMethod(.catmullRom)
                .foregroundStyle(by: .value("Metric", "Control"))
                .symbol(by: .value("Metric", "Control"))
            BarMark(x: .value("Form", formData.title), y: .value("Average Score", formData.value))
                .interpolationMethod(.catmullRom)
                .foregroundStyle(by: .value("Metric", "Form"))
                .symbol(by: .value("Metric", "Form"))
        }
        .frame(height: 180)
    }
}

#Preview {
    CoachScoresChartView()
}
