//
//  GroupPlayerView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import SwiftUI

struct GroupPlayerView: View {
    var player: Player
    var body: some View {
        HStack {
            CirclePhotoView(url: player.image)
            
            Text(player.name)
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
            
//            Image(systemName: "trash")
//                .foregroundStyle(Color.red)
//                .onTapGesture {
//                    print("delete \(player.name)")
//                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    GroupPlayerView(player: Player(id: 1234, name: "Lionel Messi", email: "lmessi@gmail.com", image: "null"))
}
