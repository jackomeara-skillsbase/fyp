//
//  ChartPoint.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 03/03/2024.
//

import Foundation

struct ChartPoint: Identifiable {
    var title: String
    var value: Double
    var id = UUID()
}
