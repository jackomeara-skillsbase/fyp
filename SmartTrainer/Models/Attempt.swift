//
//  Attempt.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import Foundation

struct Attempt: Identifiable, Codable, Hashable {
    let id: Int64
    let date: Date
    let video_url: String
    let player_name: String
    let player_id: String
    let technique_name: String
    let technique_id: String
}
