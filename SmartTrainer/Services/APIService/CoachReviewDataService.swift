//
//  CoachReviewDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class CoachReviewDataService {
    static func getAttemptReview(attemptID: String) async throws -> CoachReview? {
        do {            
            guard let snapshot = try? await Firestore.firestore().collection("coach_reviews").document(attemptID).getDocument() else { return nil }
            
            let attempt = try snapshot.data(as: CoachReview.self)
            return attempt
            
        } catch {
            print("DEBUG: Could not get coach review: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func reviewAttempt(review: CoachReview) async throws {
        do {
            // encode review and add it
            let encodedReview = try Firestore.Encoder().encode(review)
            do {
                try await Firestore.firestore().collection("coach_reviews").document(review.id).setData(encodedReview)
            }
        } catch {
            
            print("DEBUG: Couldn't create coach review: \(error.localizedDescription)")
        }
    }
}
