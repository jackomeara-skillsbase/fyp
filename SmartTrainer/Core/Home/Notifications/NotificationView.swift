//
//  NotificationView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 15/04/2024.
//

import SwiftUI

struct NotificationView: View {
    var notification: Notification
    @Binding var notifications: [Notification]
    
    var body: some View {
        HStack {
            Text(notification.date.toString(format:"HH:mm"))
                .padding(.horizontal, 6)
                .foregroundStyle(.accent)
            Text(notification.message)
            Spacer()
            Button {
                Task {
                    notifications.removeAll(where: {$0.id == notification.id})
                    do {
                        await try NotificationDataService.deleteNotification(id: notification.id)
                    } catch {}
                }
            } label: {
                Text("Dismiss")
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.red)
                    .cornerRadius(6)
            }
            .padding(.horizontal, 6)
        }
    }
}

#Preview {
    NotificationView(notification: Notification(id: "", date: Date(), user_id: "", message: "AI Review complete!"), notifications: .constant([]))
}
