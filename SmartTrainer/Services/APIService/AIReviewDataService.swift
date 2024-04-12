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
            guard let snapshot = try? await Firestore.firestore().collection("ai_reviews").whereField("attempt_id", isEqualTo: attemptID).getDocuments().documents else { return nil }
            if snapshot.count > 0 {
                let attempt = try snapshot[0].data(as: AIReview.self)
                return attempt
            } else {
                return nil
            }
        } catch {
            print("DEBUG: Could not get AI review: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func uploadAIReview(review: AIReview) async throws {
        do {
            let encodedReview = try Firestore.Encoder().encode(review)
            print(review)
            do {
                try await Firestore.firestore().collection("ai_reviews").document(review.id).setData(encodedReview)
                print("review uploaded")
            }
        } catch {
            print("DEBUG: Could not upload AI review: \(error.localizedDescription)")
        }
    }
    
    static func flagAIReview(review: AIReview, description: String) async throws {
        do {
            let newReview = AIReview(id: review.id, date: review.date, range: review.range, control: review.control, form: review.form, attempt_id: review.attempt_id, flagged: true, flagged_description: description)
            let encodedReview = try Firestore.Encoder().encode(newReview)
            guard let _ = try? await Firestore.firestore().collection("ai_reviews").document(review.id).updateData(encodedReview) else { return }
        } catch {
            print("DEBUG: Could not flag AI review: \(error.localizedDescription)")
        }
    }
}
