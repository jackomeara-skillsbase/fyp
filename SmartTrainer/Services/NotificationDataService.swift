//
//  NotificationDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 19/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class NotificationDataService {
    static func fetchNotifications() async throws -> [Notification] {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return [] }

            guard let snapshot = try? await Firestore.firestore().collection("notifications").whereField("user_id", isEqualTo: uid).getDocuments() else { return [] }
            
            var notificationsList: [Notification] = []
            for firebaseNotification in snapshot.documents {
                let notification = try firebaseNotification.data(as: Notification.self)
                notificationsList.append(notification)
            }
            return notificationsList
        } catch {
            print("DEBUG: Error fetching notifications: \(error.localizedDescription)")
        }
        return []
    }
}
