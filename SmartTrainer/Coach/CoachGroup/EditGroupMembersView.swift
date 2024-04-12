//
//  EditGroupMembersView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import SwiftUI

struct EditGroupMembersView: View {
    @EnvironmentObject private var store: Store
    var group: PlayersGroup
    @State private var players: [User] = .init()
    @State private var playerAdded: [Bool] = .init()
    
    var body: some View {
            VStack {
                List(playerAdded.indices, id:\.self) {index in
                    HStack {
                        Text(players[index].name)
                            .foregroundStyle(Color.theme.accent)
                        Spacer()
                        Toggle("", isOn: $playerAdded[index])
                    }
                }
                .listStyle(PlainListStyle())
                Button {
                    var ids: [String] = [String]()
                    for (index, value) in playerAdded.enumerated() {
                        if value {
                            ids.append(players[index].id)
                        }
                    }
                    Task {
//                        await group.updateMembers(players: ids)
                    }
                } label: {
                    Text("Save")
                }
            }
            .task {
                self.players = await User.players
                self.playerAdded = self.players.map { player in group.player_ids.contains(player.id) }
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
