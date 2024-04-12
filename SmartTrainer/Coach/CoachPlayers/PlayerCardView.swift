//
//  PlayerCard.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct PlayerCardView: View {
    let player: User
    var body: some View {
        HStack {
            CirclePhotoView(url: player.image_url, size: 50)
            Text(player.name)
                .padding(.horizontal)
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
            Spacer()
        }
    }
}

#Preview {
    PlayerCardView(player: User(id: "1234", name: "Kobe Bryant", email: "", role: userRole.player, image_url: ""))
}
