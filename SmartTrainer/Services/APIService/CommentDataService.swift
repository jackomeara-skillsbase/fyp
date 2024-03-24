//
//  CommentDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 23/03/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class CommentDataService {
    static func getCommentsForMedia(mediaID: String) async throws -> [Comment]? {
        do {
            guard let snapshot = try? await Firestore.firestore().collection("comments").whereField("media_id", isEqualTo: mediaID).getDocuments() else { return [] }
            
            var commentsList: [Comment] = []
            for firebaseComment in snapshot.documents {
                let comment = try firebaseComment.data(as: Comment.self)
                commentsList.append(comment)
            }
            return commentsList
        } catch {
            print("DEBUG: Error fetching comments: \(error.localizedDescription)")
        }
        return []
    }
}
