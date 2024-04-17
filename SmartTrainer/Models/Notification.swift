//
//  Notification.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import Foundation

struct Notification: Identifiable, Codable, Hashable {
    let id: String
    let date: Date
    let user_id: String
    let message: String
    
    static var all: [Notification] {
        get async {
            do {
                var notifications = try await NotificationDataService.fetchNotifications()
                notifications.sort { $0.date > $1.date }
                return notifications
            } catch { return [] }
        }
    }
}
