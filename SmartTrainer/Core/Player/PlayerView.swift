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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        ProfileBaseView(user: player)
                            .environmentObject(store)
                        
                        NavigationLink("View Report", destination: PlayerReportView())
                            .padding(10)
                        
                        HStack {
                            Text("Attempts")
                                .foregroundStyle(Color.theme.accent)
                                .font(.title)
                            Spacer()
                        }
                        .padding()
                        
                        ForEach(store.attempts.filter {$0.player_id == player.id}, id: \.self) { attempt in
                            AttemptCardView(attempt: attempt)
                                .background(NavigationLink("", destination: AttemptResourceView(attempt: attempt))
                                    .opacity(0))
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    PlayerView(player: User(id: "123456", name: "Michael Jordan", email: "mj@gmail.com", role: userRole.player, image_url: ""))
}
