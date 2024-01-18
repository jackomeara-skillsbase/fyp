//
//  PlayerCard.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct PlayerCardView: View {
    let player: Player
    var body: some View {
        HStack {
            CirclePhotoView(url: player.profilePhoto, size: 50)
            Text(player.name)
                .padding(.horizontal)
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
            Spacer()
        }
    }
}

#Preview {
    PlayerCardView(player: Player(id: UUID(), name: "Kobe Bryant", email: "", profilePhoto: "player"))
}
