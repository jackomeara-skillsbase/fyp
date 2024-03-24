//
//  AIReviewDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 14/02/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AIReviewDataService {
    static func getAIReview(attemptID: String) async throws -> AIReview? {
        do {
            guard let snapshot = try? await Firestore.firestore().collection("ai_reviews").document(attemptID).getDocument() else { return nil }
            let attempt = try snapshot.data(as: AIReview.self)
            return attempt
        } catch {
            print("DEBUG: Could not get AI review: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func uploadAIReview(review: AIReview) async throws {
        do {
            let encodedReview = try Firestore.Encoder().encode(review)
            do {
                try await Firestore.firestore().collection("ai_reviews").document(review.id).setData(encodedReview)
            }
        } catch {
            print("DEBUG: Could not upload AI review: \(error.localizedDescription)")
        }
    }
}
