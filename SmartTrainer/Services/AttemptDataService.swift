//
//  AttemptDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 12/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AttemptDataService {
    static func createAttempt(attempt: Attempt) async throws {
        do {
            let encodedAttempt = try Firestore.Encoder().encode(attempt)
            try await Firestore.firestore().collection("attempts").document(attempt.id).setData(encodedAttempt)
        } catch {
            print("DEBUG: Couldn't create attempt: \(error.localizedDescription)")
        }
    }
    
    static func getAttemptsByPlayer() async throws -> [Attempt] {
        do {
            // get ID of logged-in player
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            
            // get attempts by this player
            guard let snapshot = try? await Firestore.firestore().collection("attempts").whereField("player_id", isEqualTo: uid).getDocuments() else { return [] }
            
            // convert to Attempt object and add to array
            var attemptsList: [Attempt] = []
            for firebaseAttempt in snapshot.documents {
                let attempt = try firebaseAttempt.data(as: Attempt.self)
                attemptsList.append(attempt)
            }
            return attemptsList
        } catch {
            print("DEBUG: Couldn't get attempts for logged in player: \(error.localizedDescription)")
        }
        return []
    }
    
    static func getAttemptsForCoach() async throws -> [Attempt] {
        do {
            // get ID of coach
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            
            // get active relationships for coach
            guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("coach_id", isEqualTo: uid).whereField("status", isEqualTo: "accepted").getDocuments() else { return [] }
            
            // get array of player IDs that coach is responsible for
            var playersList: [String] = []
            for firebaseRelationship in snapshot.documents {
                let relationshipData = try firebaseRelationship.data(as: Relationship.self)
                playersList.append(relationshipData.player_id)
            }
            
            // get attempts for players under coach
            guard let snapshot = try? await Firestore.firestore().collection("attempts").whereField("player_id", in: playersList).getDocuments() else { return [] }
            
            // convert to Attempt object and add to array
            var attemptsList: [Attempt] = []
            for firebaseAttempt in snapshot.documents {
                let attempt = try firebaseAttempt.data(as: Attempt.self)
                attemptsList.append(attempt)
            }
            return attemptsList
        } catch {
            print("DEBUG: Couldn't get attempts for coach: \(error.localizedDescription)")
        }
        return []
    }
    
}
