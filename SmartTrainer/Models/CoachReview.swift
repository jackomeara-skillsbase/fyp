//
//  CoachReview.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import Foundation

struct CoachReview: Identifiable, Codable, Hashable {
    let id: Int
    let date: Date
    let overall: Int
    let depth: Int
    let range: Int
    let control: Int
    let comments: String
}
