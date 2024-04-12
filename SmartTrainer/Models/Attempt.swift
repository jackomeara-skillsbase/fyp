//
//  Attempt.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import Foundation

//struct Attempt: Identifiable, Codable, Hashable {
//    let id: String
//    let date: Date
//    let video_url: String
//    let player_name: String
//    let player_id: String
//    let technique_name: String
//    let technique_id: String
//}

struct Attempt: Identifiable, Codable, Hashable {
    let id: String
    let date: Date
    let caption: String
    var video_url: String
    var imgs: [String]
    let player_name: String
    let player_id: String
    let technique_name: String
    let technique_id: String
    let permissions: PermissionLevel
    let custom_permissions: [String]?
    let ai_reviewed: Bool
    let coach_reviewed: Bool
    
    static var playersAttempts: [Attempt] {
        get async {
            do {
                var attempts = try await AttemptDataService.getAttemptsByPlayer()
                attempts.sort { $0.date > $1.date }
                return attempts
            } catch {}
            return []
        }
    }
    
    static var coachesAttempts: [Attempt] {
        get async {
            do {
                var attempts = try await AttemptDataService.getAttemptsForCoach()
                attempts.sort { $0.date > $1.date }
                return attempts
            } catch {}
            return []
        }
    }
    
    enum PermissionLevel: String, Codable {
        case priv, custom, pub
    }
}
