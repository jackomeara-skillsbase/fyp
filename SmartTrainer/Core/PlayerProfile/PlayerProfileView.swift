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
    
    var body: some View {
        if let currentUser = store.currentUser {
            ZStack {
                // background layer
                    Color.theme.background
                        .ignoresSafeArea()
                
                // content layer
                ScrollView {
                    VStack {
                        ProfileBaseView(name: currentUser.name, email: currentUser.email)
                        
                        HStack {
                            Spacer()
                            VStack {
                                Text("Attempts")
                                    .foregroundStyle(Color.theme.secondaryText)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 2)
                                Text("\(store.attempts.count)")
                                    .foregroundStyle(Color.theme.accent)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }
                            Spacer()
                            VStack {
                                Text("A Grades")
                                    .foregroundStyle(Color.theme.secondaryText)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 2)
                                Text("12")
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
            ForEach(store.coaches, id: \.self) { coach in
                CoachRowView(coach: coach)
            }
        }
    }
}

#Preview {
    PlayerProfileView()
}
