//
//  SmartTrainerTabView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct SmartTrainerTabView: View {
    @EnvironmentObject private var store: Store
    var body: some View {
        if let currentUser = store.currentUser {
            if !(currentUser.isCoach) {
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                        }
                        .environmentObject(store)
                    PlayerRecordView()
                        .tabItem {
                            Image(systemName: "plus")
                        }
                        .environmentObject(store)
                    PlayerProfileView()
                        .tabItem {
                            Image(systemName: "person")
                        }
                        .environmentObject(store)
                }
            }
            else {
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                        }
                        .environmentObject(store)
                    CoachPlayersView()
                        .tabItem {
                            Image(systemName: "person.3")
                        }
                        .environmentObject(store)
                    CoachProfileView()
                        .tabItem {
                            Image(systemName: "person")
                        }
                        .environmentObject(store)
                    DrawFeedbackView()
                        .tabItem {
                            Image(systemName: "pencil")
                        }
                        .environmentObject(store)
                }
            }
        }
        else {
            Text("Going to tab view but no user found!")
        }
    }
}

#Preview {
    SmartTrainerTabView()
        .environmentObject(Store())
}
