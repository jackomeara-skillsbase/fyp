//
//  NotificationsView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 28/03/2024.
//

import SwiftUI

struct NotificationsView: View {
    @State private var notifications: [Notification] = .init()
    var body: some View {
        List(notifications) { notification in
            NotificationView(notification: notification, notifications: $notifications)
        }
        .listStyle(PlainListStyle())
        .task {
            self.notifications = await Notification.all
        }
    }
}

#Preview {
    NotificationsView()
}
