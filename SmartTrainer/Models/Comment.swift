//
//  Comment.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 23/03/2024.
//

import Foundation

struct Comment: Identifiable, Codable, Hashable {
    let id: String
    let media_id: String
    let date: Date
    let user_id: String
    let user_name: String
    let comment: String
}
