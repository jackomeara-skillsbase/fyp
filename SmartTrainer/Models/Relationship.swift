//
//  Relationship.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import Foundation

struct Relationship: Identifiable, Codable, Hashable {
    let id: Int64
    let player_email: String
    let coach_email: String
    let status: String
}
