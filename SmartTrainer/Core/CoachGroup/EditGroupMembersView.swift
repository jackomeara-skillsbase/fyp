//
//  EditGroupMembersView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import SwiftUI

struct EditGroupMembersView: View {
    var group: PlayersGroup
    var players: [Player] = []
    var body: some View {
        VStack {
            List(players) { player in
                memberCard(player: player)
            }
            .listStyle(PlainListStyle())
        }
    }
}

extension EditGroupMembersView {
    struct memberCard: View {
        var player: Player
        var body: some View {
            HStack {
                Text(player.name)
                    .foregroundStyle(Color.theme.accent)
                Spacer()
                Toggle("", isOn: .constant(false))
                    .padding()
            }
        }
    }
}
//
//#Preview {
//    EditGroupMembersView(group: PlayersGroup(id: 1, name: "NBA Players", members: [
//        Player(id: 1, name: "Michael Jordan", email: "mj@gmail.com", image: "null"),
//        Player(id: 2, name: "Kobe Bryant", email: "kb@gmail.com", image: "null"),
//        Player(id: 3, name: "Shaquille O'Neal", email: "shaq@gmail.com", image: "null"),
//        Player(id: 4, name: "Kristaps Porzingis", email: "kp@gmail.com", image: "null"),
//    ]),
//    players: [
//        Player(id: 1, name: "Michael Jordan", email: "mj@gmail.com", image: "null"),
//        Player(id: 2, name: "Kobe Bryant", email: "kb@gmail.com", image: "null"),
//        Player(id: 3, name: "Shaquille O'Neal", email: "shaq@gmail.com", image: "null"),
//        Player(id: 4, name: "Kristaps Porzingis", email: "kp@gmail.com", image: "null"),
//        Player(id: 5, name: "Andre Drummond", email: "mj@gmail.com", image: "null"),
//        Player(id: 6, name: "LeBron James", email: "kb@gmail.com", image: "null"),
//        Player(id: 7, name: "Jason Williams", email: "shaq@gmail.com", image: "null"),
//        Player(id: 8, name: "Steph Curry", email: "kp@gmail.com", image: "null"),
//    ])
//}
