//
//  RelationshipDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class RelationshipDataService {
    static func requestCoach(coachEmail: String) async throws -> String {
        do {
            // get ID of logged-in player
            guard let uid = Auth.auth().currentUser?.uid else { return "" }
            guard let coachID = try? await UserDataService.getUserIDByEmail(email: coachEmail) else { return "no_coach" }
            
            guard let relationshipExists = try? await checkRelationshipExistsAsPlayer(coachEmail: coachEmail) else { return "" }
            if relationshipExists {
                // get id of relationship so it can be updated
                guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("coach_id", isEqualTo: coachID).whereField("player_id", isEqualTo: uid).getDocuments() else { return "" }
                if !snapshot.documents.isEmpty {
                    // update the relationship
                    let relationship = snapshot.documents[0]
                    
                    // don't allow already accepted relationship to send request
                    if try relationship.data(as: Relationship.self).status == "accepted" { return "already_accepted" }
                    
                    // create relationship object and send it
                    let documentID = relationship.documentID
                    let relationshipObject = Relationship(id: documentID, player_id: uid, coach_id: coachID, status: "pending")
                    let encodedRelationship = try Firestore.Encoder().encode(relationshipObject)
                    try await Firestore.firestore().collection("relationships").document(documentID).updateData(encodedRelationship)
                }
            } else {
                // create relationship with pending status
                let relationship = Relationship(id: UUID().uuidString, player_id: uid, coach_id: coachID, status: "pending")
                let encodedRelationship = try Firestore.Encoder().encode(relationship)
                try await Firestore.firestore().collection("relationships").document(relationship.id).setData(encodedRelationship)
            }
            } catch {
                print("DEBUG: Couldn't request coach: \(error.localizedDescription)")
        }
        return "success"
    }
    
    static func checkRelationshipExistsAsPlayer(coachEmail: String) async throws -> Bool {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return false }
            guard let coachID = try await UserDataService.getUserIDByEmail(email: coachEmail) else { return false }
            guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("coach_id", isEqualTo: coachID).whereField("player_id", isEqualTo: uid).getDocuments() else { return false }
            if snapshot.documents.isEmpty { return false }
            return true
        } catch {
            print("DEBUG: Error when checking relationship exists: \(error.localizedDescription)")
        }
        return false
    }
    
    static func checkRelationshipExistsAsCoach(playerEmail: String) async throws -> Bool {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return false }
            guard let playerID = try await UserDataService.getUserIDByEmail(email: playerEmail) else { return false }
            guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("coach_id", isEqualTo: uid).whereField("player_id", isEqualTo: playerID).getDocuments() else { return false }
            if snapshot.documents.isEmpty { return false }
            return true
        } catch {
            print("DEBUG: Error when checking relationship exists: \(error.localizedDescription)")
        }
        return false
    }
    
    static func getRelationshipStatusAsPlayer(coachEmail: String) async throws -> String {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return "" }
            guard let coachID = try await UserDataService.getUserIDByEmail(email: coachEmail) else { return "" }
            guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("coach_id", isEqualTo: coachID).whereField("player_id", isEqualTo: uid).getDocuments() else { return "" }
            if snapshot.documents.isEmpty { return "" }
            return try snapshot.documents[0].data(as: Relationship.self).status
            
        } catch {
            print("DEBUG: Error when checking relationship exists: \(error.localizedDescription)")
        }
        return ""
    }
    
    static func getRelationshipStatusAsCoach(playerEmail: String) async throws -> String {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return "" }
            guard let playerID = try await UserDataService.getUserIDByEmail(email: playerEmail) else { return "" }
            guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("coach_id", isEqualTo: uid).whereField("player_id", isEqualTo: playerID).getDocuments() else { return "" }
            if snapshot.documents.isEmpty { return "" }
            return try snapshot.documents[0].data(as: Relationship.self).status
            
        } catch {
            print("DEBUG: Error when checking relationship exists: \(error.localizedDescription)")
        }
        return ""
    }
    
    static func acceptPlayerRequest(playerID: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("coach_id", isEqualTo: uid).whereField("player_id", isEqualTo: playerID).getDocuments() else { return }
        if !snapshot.documents.isEmpty {
            // update the relationship
            let relationship = snapshot.documents[0]
            
            // don't allow already accepted relationship to send request
            if try relationship.data(as: Relationship.self).status == "accepted" { return }
            
            // create relationship object and send it
            let documentID = relationship.documentID
            let relationshipObject = Relationship(id: documentID, player_id: playerID, coach_id: uid, status: "accepted")
            let encodedRelationship = try Firestore.Encoder().encode(relationshipObject)
            try await Firestore.firestore().collection("relationships").document(documentID).updateData(encodedRelationship)
        }
    }
    
    static func rejectPlayerRequest(playerID: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("coach_id", isEqualTo: uid).whereField("player_id", isEqualTo: playerID).getDocuments() else { return }
        if !snapshot.documents.isEmpty {
            // update the relationship
            let relationship = snapshot.documents[0]
            
            // don't allow already accepted relationship to send request
            if try relationship.data(as: Relationship.self).status == "accepted" { return }
            
            // create relationship object and send it
            let documentID = relationship.documentID
            let relationshipObject = Relationship(id: documentID, player_id: playerID, coach_id: uid, status: "rejected")
            let encodedRelationship = try Firestore.Encoder().encode(relationshipObject)
            try await Firestore.firestore().collection("relationships").document(documentID).updateData(encodedRelationship)
        }
    }
    
    static func getPendingRelationshipsForCoach() async throws -> [Relationship] {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("status", isEqualTo: "pending").whereField("coach_id", isEqualTo: uid).getDocuments() else { return [] }
            // convert to Relationship object and add to array
            var relationshipsList: [Relationship] = []
            for firebaseRelationship in snapshot.documents {
                let relationship = try firebaseRelationship.data(as: Relationship.self)
                relationshipsList.append(relationship)
            }
            return relationshipsList
        } catch {
            print("DEBUG: Error while getting pending relationships: \(error.localizedDescription)")
        }
        return []
    }
    
    static func getPendingRelationshipsForPlayer() async throws -> [Relationship] {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            guard let snapshot = try? await Firestore.firestore().collection("relationships").whereField("status", isEqualTo: "pending").whereField("player_id", isEqualTo: uid).getDocuments() else { return [] }
            // convert to Relationship object and add to array
            var relationshipsList: [Relationship] = []
            for firebaseRelationship in snapshot.documents {
                let relationship = try firebaseRelationship.data(as: Relationship.self)
                relationshipsList.append(relationship)
            }
            return relationshipsList
        } catch {
            print("DEBUG: Error while getting pending relationships: \(error.localizedDescription)")
        }
        return []
        }
}
