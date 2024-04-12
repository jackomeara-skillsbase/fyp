//
//  CoachProfileView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct CoachProfileView: View {
    @EnvironmentObject private var store: Store
    @State private var playersCount: Int = 0
    @State private var attemptsCount: Int = 0
    var body: some View {
        if let currentUser = store.currentUser {
            VStack {
                ProfileBaseView(user: currentUser)
                    .environmentObject(store)
                    .padding(.top, 30)
                
                HStack {
                    Spacer()
                    VStack {
                        Text("Players")
                            .foregroundStyle(Color.theme.secondaryText)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 2)
                        Text("\(playersCount)")
                            .foregroundStyle(Color.theme.accent)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
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
                }
                .padding(.top, 20)
                
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
                
                Spacer()
            }
            .task {
                self.attemptsCount = await Attempt.coachesAttempts.count
                self.playersCount = await User.players.count
            }
        }
    }
}

#Preview {
    CoachProfileView()
}
