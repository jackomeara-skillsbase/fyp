//
//  User.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 07/02/2024.
//

import Foundation

enum userRole: String, Codable {
    case player, coach, manager
}

struct User: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let email: String
    let role: userRole
    var image_url: String
    
    static var coaches: [User] {
        get async {
            do {
                let coaches = try await UserDataService.fetchCoaches()
                return coaches
            } catch { return [] }
        }
    }
    
    static var requestedCoaches: [User] {
        get async {
            do {
                let coaches = try await UserDataService.fetchCoaches(status: "pending")
                return coaches
            } catch { return [] }
        }
    }
    
    static var players: [User] {
        get async {
            do {
                let players = try await UserDataService.fetchPlayers()
                return players
            } catch { return [] }
        }
    }
    
    static var requestedPlayers: [User] {
        get async {
            do {
                let requestedPlayers = try await UserDataService.fetchPlayers(status: "pending")
                return requestedPlayers
            } catch { return [] }
        }
    }
}
