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
    
    static func deleteNotification(id: String) async throws {
        do {
            guard let _ = try? await Firestore.firestore().collection("notifications").document(id).delete() else { return }
        } catch {
            print("DEBUG: Error deleting notification: \(error.localizedDescription)")
        }
    }
    
    static func createNotification(notification: Notification) async throws {
        do {
            let encodedNotification = try Firestore.Encoder().encode(notification)
            try await Firestore.firestore().collection("notifications").document(notification.id).setData(encodedNotification)
        } catch {
            print("DEBUG: Error creating notification: \(error.localizedDescription)")
        }
    }
}
