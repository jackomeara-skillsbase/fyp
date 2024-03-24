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
        if let currentUser = store.currentUser, store.isLoaded {
            if currentUser.role == userRole.player {
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                        }
                        .environmentObject(store)
                    SelectTechniqueView()
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
            else if currentUser.role == userRole.coach {
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
                }
            }
            else if currentUser.role == userRole.manager {
                TabView {
                    ManagerOverviewView()
                        .tabItem {
                            Image(systemName: "house")
                        }
                        .environmentObject(store)
                    ManagerCoachesView()
                        .tabItem {
                         Image(systemName: "person.3")
                        }
                        .environmentObject(store)
                    ManagerProfileView()
                        .tabItem {
                            Image(systemName: "person")
                        }
                        .environmentObject(store)
                }
            }
        }
        else {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
        }
    }
}

#Preview {
    SmartTrainerTabView()
        .environmentObject(Store())
}
