//
//  Group.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import Foundation

struct PlayersGroup: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let coach_id: String
    var player_ids: [String]
    
    init(id: String, name: String, coach_id: String, player_ids: [String]) {
        self.id = id
        self.name = name
        self.coach_id = coach_id
        self.player_ids = player_ids
    }
    
    init(name: String, coach_id: String, player_ids: [String]) {
        self.id = UUID().uuidString
        self.name = name
        self.coach_id = coach_id
        self.player_ids = player_ids
    }
    
    static var all: [PlayersGroup] {
        get async {
            do {
                let groups = try await GroupDataService.fetchGroups()
                return groups
            } catch { return [] }
        }
    }
    
    mutating func updateMembers(players: [String]) async {
        self.player_ids = players
        do {
            try await GroupDataService.updateGroup(group: self)
        } catch {}
    }
}
