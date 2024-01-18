//
//  Group.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import Foundation

struct PlayersGroup: Identifiable, Hashable {
    let id: UUID
    let name: String
    let members: [Player]
}
