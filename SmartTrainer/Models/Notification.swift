//
//  Notification.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import Foundation

struct Notification: Identifiable, Codable, Hashable {
    let id: Int64
    let date: Date
    let is_player: Bool
    let subject_id: Int64
    let message: String
}
