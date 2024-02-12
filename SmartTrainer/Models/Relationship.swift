//
//  Relationship.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import Foundation

struct Relationship: Identifiable, Codable, Hashable {
    let id: String
    let player_id: String
    let coach_id: String
    let status: String
}
