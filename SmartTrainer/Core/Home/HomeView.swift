//
//  PlayerHomeView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: Store
    @State private var attempts: [Attempt] = .init()
    @State private var attemptsLoaded: Bool = false
    @State private var notifications: [Notification] = .init()
    
    @State private var showNotifications: Bool = false
    @State private var searchText: String = ""
    
    var timer = Timer.publish(every: 7, on: .main, in: .common).autoconnect()
    
    private func filterSearch(allAttempts: [Attempt], searchText: String) -> [Attempt] {
        if searchText == "" {
            return allAttempts
        } else {
            return allAttempts.filter { attempt in
                attempt.technique_name.range(of: searchText, options: .caseInsensitive) != nil ||
                attempt.player_name.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background layer
                Color.theme.background
                    .ignoresSafeArea()
                
                // content layer
                VStack {
                    HomeHeaderView(showNotifications: $showNotifications, attempts: $attempts, attemptsLoaded: $attemptsLoaded, notifications: $notifications)
                        .environmentObject(store)
                    
                    if showNotifications {
                        NotificationsView()
                    } else {
                        SearchBarView(promptText: "Search for an attempt...", searchText: $searchText)
                        
                        if store.uploadingProgress != -1 {
                            LoadingCardView()
                        }
                        
                        if attemptsLoaded {
                            if attempts.count > 0 {
                                attemptsList
                            } else {
                                Text("No Attempts Found")
                                    .padding(.top)
                                    .foregroundStyle(.accent)
                            }
                        } else {
                            ProgressView()
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .task {
            self.attemptsLoaded = false
            self.notifications = await Notification.all
            if let currentUser = store.currentUser {
                if currentUser.role == userRole.coach {
                    self.attempts = await Attempt.coachesAttempts
                } else {
                    self.attempts = await Attempt.playersAttempts
                }
                self.attemptsLoaded = true
            }
        }
        .onReceive(timer) { _ in
            Task {
                let new_notifications = await Notification.all
                if new_notifications.count > self.notifications.count {
                    self.notifications = new_notifications
                    store.uploadingProgress = -1
                    await store.sendToast(type: ToastType.info, message: "You have new notifications")
                }
            }
        }
    }
}

extension HomeView {
    private var attemptsList: some View {
        List(filterSearch(allAttempts: attempts, searchText: searchText)) { attempt in
            AttemptCardView(attempt: attempt)
                .background(NavigationLink("",
                                           destination: AttemptFeedView(attempt: attempt)
                    .environmentObject(store))
                    .opacity(0))
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    HomeView()
        .environmentObject(Store())
}
