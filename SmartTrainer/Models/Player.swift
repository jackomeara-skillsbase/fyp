//
//  Player.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import Foundation

struct Player: Identifiable, Hashable {
    let id: UUID
    let name: String
    let email: String
    let profilePhoto: String
}
