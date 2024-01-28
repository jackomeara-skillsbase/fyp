//
//  Group.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import Foundation

struct PlayersGroup: Identifiable, Codable, Hashable {
    let id: Int64
    let name: String
    let coach_id: Int
    let members: [Member]
}

struct Member: Identifiable, Codable, Hashable {
    let id: Int
}
