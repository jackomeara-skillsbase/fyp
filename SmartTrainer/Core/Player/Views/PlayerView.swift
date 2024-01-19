//
//  PlayerView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct PlayerView: View {
    @StateObject private var vm: PlayerViewModel = PlayerViewModel()
    let player: Player
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ProfileBaseView(name: player.name, email: player.email, profilePhoto: player.image)
                    
                    Button(action: {
                        print("generating report...")
                    }) {
                        Text("Generate Report")
                            .foregroundStyle(Color.white)
                            .padding(.horizontal)
                    }
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.vertical)
                    
                    HStack {
                        Text("Attempts")
                            .foregroundStyle(Color.theme.accent)
                            .font(.title)
                        Spacer()
                    }
                    .padding()
                    
                    ForEach(vm.attempts, id: \.self) { attempt in
                        AttemptCardView(attempt: attempt)
                            .background(NavigationLink("", destination: PlayerAttemptView(attempt: attempt))
                                .opacity(0))
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    PlayerView(player: Player(id: 123456, name: "Michael Jordan", email: "mj@gmail.com", image: "player"))
}
