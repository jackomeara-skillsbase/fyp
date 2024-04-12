//
//  UserDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserDataService {
    static func fetchPlayers(status: String = "accepted") async throws -> [User] {
        do {
            // get ID of coach
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            
            // get active relationships for coach
            guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("coach_id", isEqualTo: uid).whereField("status", isEqualTo: status).getDocuments() else { return [] }
            
            // get array of player IDs that coach is responsible for
            var playersList: [String] = []
            for firebaseRelationship in snapshot.documents {
                let relationshipData = try firebaseRelationship.data(as: Relationship.self)
                playersList.append(relationshipData.player_id)
            }
            
            if playersList.isEmpty { return [] }
            
            // get actual User objects of these players
            guard let snapshot = try? await Firestore.firestore().collection("users").whereField("id", in: playersList).getDocuments() else { return [] }
            
            // convert to User object
            var usersList: [User] = []
            for firebaseUser in snapshot.documents {
                let user = try firebaseUser.data(as: User.self)
                usersList.append(user)
            }
            return usersList
        } catch {
            print("DEBUG: Could not fetch players: \(error.localizedDescription)")
        }
        return []
    }
    
    static func getUserIDByEmail(email: String) async throws -> String? {
        do {
            guard let snapshot = try? await Firestore.firestore().collection("users").whereField("email", isEqualTo: email).getDocuments() else { return nil }
            if snapshot.documents.isEmpty { return nil }
            let user = try snapshot.documents[0].data(as: User.self)
            return user.id
        } catch {
            print("DEBUG: Error occurred while getting user ID: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func fetchCoaches(status: String = "accepted") async throws -> [User] {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            
            guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("player_id", isEqualTo: uid).whereField("status", isEqualTo: status).getDocuments() else { return [] }
            
            var coachesList: [String] = []
            for firebaseRelationship in snapshot.documents {
                let relationshipData = try firebaseRelationship.data(as: Relationship.self)
                coachesList.append(relationshipData.coach_id)
            }
            
            if coachesList.isEmpty { return [] }
            
            guard let snapshot = try? await Firestore.firestore().collection("users").whereField("id", in: coachesList).getDocuments() else { return [] }
            
            // convert to User object
            var usersList: [User] = []
            for firebaseUser in snapshot.documents {
                let user = try firebaseUser.data(as: User.self)
                usersList.append(user)
            }
            
            return usersList
            
        } catch {
            print("DEBUG: Error occurred while getting coaches for player")
        }
        return []
    }
}
