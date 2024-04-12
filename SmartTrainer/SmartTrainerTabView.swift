//
//  SmartTrainerTabView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct SmartTrainerTabView: View {
    @EnvironmentObject private var store: Store
    
    init() {
        UITabBar.appearance().barTintColor = .background
    }
    
    var body: some View {
        ZStack {
            if let currentUser = store.currentUser, store.isLoaded {
                if currentUser.role == userRole.player {
                    TabView(selection: $store.selectedTab) {
                        HomeView()
                            .tabItem {
                                Image(systemName: "house")
                            }
                            .tag(0)
                            .environmentObject(store)
                        SelectTechniqueView()
                            .tabItem {
                                Image(systemName: "plus")
                            }
                            .tag(1)
                            .environmentObject(store)
                        PlayerProfileView()
                            .tabItem {
                                Image(systemName: "person")
                            }
                            .tag(2)
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
            
            if store.showToast {
                VStack {
                    ToastView(type: store.toastType, message: store.toastMessage)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    SmartTrainerTabView()
        .environmentObject(Store())
}
