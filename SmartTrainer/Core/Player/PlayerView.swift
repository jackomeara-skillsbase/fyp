//
//  PlayerView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject private var store: Store
    let player: User
    @State private var attempts: [Attempt] = .init()
    
    private func filterAttempts(allAttempts: [Attempt]) -> [Attempt] {
        return allAttempts.filter { $0.player_id == player.id }
    }
    
    var body: some View {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                    VStack {
                        ProfileBaseView(user: player, isCurrentUser: false)
                            .environmentObject(store)
                        
                        NavigationLink("View Report", destination: PlayerReportView(player: player))
                            .padding(10)
                        
                        HStack {
                            Text("Attempts")
                                .foregroundStyle(Color.theme.accent)
                                .font(.title)
                            Spacer()
                        }
                        .padding()
                        
                        List(filterAttempts(allAttempts: attempts)) { attempt in
                            AttemptCardView(attempt: attempt)
                                .background(NavigationLink("", destination: AttemptFeedView(attempt: attempt)
                                    .environmentObject(store))
                                    .opacity(0))
                        }
                        .listStyle(PlainListStyle())
                        
                        Spacer()
                    }
            }
            .task {
                self.attempts = await Attempt.coachesAttempts
            }
    }
}

#Preview {
    PlayerView(player: User(id: "123456", name: "Michael Jordan", email: "mj@gmail.com", role: userRole.player, image_url: ""))
}
