//
//  GroupDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 02/04/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class GroupDataService {
    static func fetchGroups() async throws -> [PlayersGroup] {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            
            guard let snapshot = try? await Firestore.firestore().collection("groups").whereField("coach_id", isEqualTo: uid).getDocuments() else { return [] }
            
            var groupsList: [PlayersGroup] = []
            for firebaseGroup in snapshot.documents {
                let groupData = try firebaseGroup.data(as: PlayersGroup.self)
                groupsList.append(groupData)
            }
            
            return groupsList
        } catch {
            print("DEBUG: Could not fetch groups: \(error.localizedDescription)")
        }
        return []
    }
    
    static func createGroup(group: PlayersGroup) async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let encodedGroup = try Firestore.Encoder().encode(group)
            guard let _  = try? await Firestore.firestore().collection("groups").document(group.id).setData(encodedGroup) else { return }
        } catch {
            print("DEBUG: Could not create group: \(error.localizedDescription)")
        }
    }
}
