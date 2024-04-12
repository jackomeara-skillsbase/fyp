//
//  PlayerProfileView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct PlayerProfileView: View {
    @State private var showNewCoach: Bool = false
    @State private var searchText: String = ""
    @EnvironmentObject private var store: Store
    @State private var coaches: [User] = .init()
    @State private var requestedCoaches: [User] = .init()
    @State private var techniquesCount: Int = 0
    @State private var attemptsCount: Int = 0
    
    var body: some View {
        if let currentUser = store.currentUser {
            ZStack {
                // background layer
                    Color.theme.background
                        .ignoresSafeArea()
                
                // content layer
                ScrollView {
                    VStack {
                        ProfileBaseView(user: currentUser)
                            .environmentObject(store)
                            .padding(.top, 30)
                        
                        HStack {
                            Spacer()
                            VStack {
                                Text("Attempts")
                                    .foregroundStyle(Color.theme.secondaryText)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 2)
                                Text("\(attemptsCount)")
                                    .foregroundStyle(Color.theme.accent)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }
                            Spacer()
                            VStack {
                                Text("Techniques")
                                    .foregroundStyle(Color.theme.secondaryText)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 2)
                                Text("\(techniquesCount)")
                                    .foregroundStyle(Color.theme.accent)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }
                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        coachesSection
                        
                        Spacer()
                        
                        Button(action: {
                            store.signOut()
                        }) {
                            Text("Log Out")
                                .foregroundStyle(Color.white)
                                .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                    }
                }
                
                if showNewCoach {
                    // background to disable content behind popup
                    Color.theme.secondaryText.opacity(0.7)
                        .ignoresSafeArea()
                    
                    // show popup
                    NewCoachPopupView(searchText: $searchText, showPopup: $showNewCoach)
                        .environmentObject(store)
                }
            }
            .task {
                self.coaches = await User.coaches
                self.requestedCoaches = await User.requestedCoaches
                self.techniquesCount = await Technique.all.count
                self.attemptsCount = await Attempt.playersAttempts.count
            }
        }
    }
}

extension PlayerProfileView {
    private var coachesSection: some View {
        VStack {
            HStack {
                Text("Coaches")
                    .font(.title2)
                    .foregroundStyle(Color.theme.accent)
                    .fontWeight(.bold)
                Spacer()
                CircleButtonView(iconName: "plus")
                    .onTapGesture {
                        showNewCoach = true
                    }
            }
            .padding()
            ForEach(coaches, id: \.self) { coach in
                CoachRowView(coach: coach, status: "accepted")
            }
            ForEach(requestedCoaches, id: \.self) { coach in
                CoachRowView(coach: coach, status: "pending")
            }
        }
    }
}

#Preview {
    PlayerProfileView()
}
