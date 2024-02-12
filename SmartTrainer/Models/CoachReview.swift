//
//  CoachReview.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import Foundation

struct CoachReview: Identifiable, Codable, Hashable {
    let id: String
    let date: Date
    let overall: Int
    let range: Int
    let balance: Int
    let control: Int
    let comments: String
}
