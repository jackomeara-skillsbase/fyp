//
//  TechniqueDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 26/03/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class TechniqueDataService {
    static func fetchTechniques() async throws -> [Technique] {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            
            guard let snapshot = try? await Firestore.firestore().collection("techniques").getDocuments() else { return [] }
            
            var techniquesList: [Technique] = []
            for firebaseTechnique in snapshot.documents {
                let techniqueData = try firebaseTechnique.data(as: Technique.self)
                techniquesList.append(techniqueData)
            }
            
            return techniquesList
        } catch {
            print("DEBUG: Could not fetch techniques: \(error.localizedDescription)")
        }
        return []
    }
}
