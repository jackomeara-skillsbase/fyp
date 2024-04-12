//
//  AIReview.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 14/02/2024.
//

import Foundation

struct AIReview: Identifiable, Codable, Hashable {
    let id: String
    let date: Date
    let range: String
    let control: String
    let form: String
    let attempt_id: String
    let flagged: Bool
    let flagged_description: String
}
