//
//  HomeHeaderView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 28/03/2024.
//

import SwiftUI

struct HomeHeaderView: View {
    @EnvironmentObject private var store: Store
    @Binding var showNotifications: Bool
    @State private var rotationAngle: Double = 0
    @Binding var attempts: [Attempt]
    @Binding var attemptsLoaded: Bool
    @Binding var notifications: [Notification]
    
    private func getRightIcon() -> String {
        if showNotifications {
            return "house"
        } else {
            return "bell"
        }
    }
    
    private func getTitle() -> String {
        if showNotifications {
            return "Notifications"
        } else {
            return "Home"
        }
    }
    
    var body: some View {
        HStack {
            CircleButtonView(iconName: "arrow.clockwise")
                .rotationEffect(.degrees(rotationAngle))
                .onTapGesture {
                    withAnimation(Animation.linear(duration: 1)) {
                        rotationAngle += 360
                        Task {
                            attemptsLoaded = false
                            if let currentUser = store.currentUser {
                                if currentUser.role == userRole.coach {
                                    self.attempts = await Attempt.coachesAttempts
                                } else {
                                    self.attempts = await Attempt.playersAttempts
                                }
                                attemptsLoaded = true
                            }

                        }
                    }
                }
            Spacer()
            Text(getTitle())
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.accent)
            Spacer()
            CircleButtonView(iconName: getRightIcon())
                .onTapGesture {
                    withAnimation(.spring()) {
                        showNotifications.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
}

#Preview {
    HomeHeaderView(showNotifications: .constant(false), attempts: .constant([]), attemptsLoaded: .constant(true), notifications: .constant([]))
}
