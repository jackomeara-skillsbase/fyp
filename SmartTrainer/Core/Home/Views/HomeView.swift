//
//  PlayerHomeView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var showNotifications: Bool = false
    
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
                        List(vm.notifications) { notification in
                            Text(notification.content)
                                .foregroundStyle(Color.theme.accent)
                        }
                        .listStyle(PlainListStyle())
                    } else {
                        SearchBarView(promptText: "Search for an attempt...", searchText: $vm.searchText)
                        
                        attemptsList
                    }
                    
                    Spacer()
                }
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
            List(vm.attempts) { attempt in
                AttemptCardView(attempt: attempt)
                    .background(NavigationLink("", destination: PlayerAttemptView(attempt: attempt))
                        .opacity(0))
            }
            .listStyle(PlainListStyle())
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
