//
//  PlayerHomeView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: Store
    @State private var showNotifications: Bool = false
    @State private var searchText: String = ""
    
    private func filterSearch(allAttempts: [Attempt], searchText: String) -> [Attempt] {
        if searchText == ""{
            return allAttempts
        } else {
            return allAttempts.filter { $0.technique_name.contains(searchText) }
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
                    header
                    
                    if showNotifications {
                        List(store.notifications) { notification in
                            Text(notification.message)
                                .foregroundStyle(Color.theme.accent)
                        }
                        .listStyle(PlainListStyle())
                    } else {
                        SearchBarView(promptText: "Search for an attempt...", searchText: $searchText)
                        
                        attemptsList
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            Task {
                try await store.fetchAttempts()
                try await store.fetchNotifications()
            }
        }
    }
}

extension HomeView {
    private var header: some View {
        HStack {
            CircleButtonView(iconName: "arrow.clockwise")
                .rotationEffect(.degrees(90))
            Spacer()
            Text(showNotifications ? "Notifications" : "Home")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: showNotifications ? "house" : "bell")
                .onTapGesture {
                    withAnimation(.spring()) {
                        showNotifications.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}

extension HomeView {
    private var attemptsList: some View {
        
        List(filterSearch(allAttempts: store.attempts, searchText: searchText)) { attempt in
                AttemptCardView(attempt: attempt)
                    .background(NavigationLink("", 
                                               destination: AttemptResource(attempt: attempt)
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
