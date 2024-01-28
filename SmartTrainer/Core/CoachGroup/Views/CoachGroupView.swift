//
//  CoachGroupView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import SwiftUI

struct CoachGroupView: View {
    var vm: CoachPlayersViewModel = CoachPlayersViewModel()
    var group: PlayersGroup
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            NavigationStack {
                VStack {
                    HStack {
                        Text(group.name)
                            .foregroundStyle(Color.theme.accent)
                            .font(.title)
                            .padding()
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Members (\(group.members.count))")
                            .foregroundStyle(Color.theme.accent)
                            .font(.headline)
                            .padding()
                        Spacer()
                    }
                    
                    List(vm.inflateMembers(group: group)) { player in
                        GroupPlayerView(player: player)
                            .background(NavigationLink("", destination: PlayerView(player: player))
                                .opacity(0))
                    }
                    .listStyle(PlainListStyle())
                    
                    NavigationLink(destination: EditGroupMembersView(group: group)) {
                        Text("Edit Members")
                    }
                    Spacer()
                }
            }
            }
    }
}

//#Preview {
//    CoachGroupView(group: PlayersGroup(id: 1, name: "NBA Players", members: [
//        Player(id: 1, name: "Michael Jordan", email: "mj@gmail.com", image: "null"),
//        Player(id: 2, name: "Kobe Bryant", email: "kb@gmail.com", image: "null"),
//        Player(id: 3, name: "Shaquille O'Neal", email: "shaq@gmail.com", image: "null"),
//        Player(id: 4, name: "Kristaps Porzingis", email: "kp@gmail.com", image: "null"),
//    ]))
//}
