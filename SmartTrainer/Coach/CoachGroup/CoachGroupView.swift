//
//  CoachGroupView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import SwiftUI

struct CoachGroupView: View {
    @EnvironmentObject private var store: Store
    @State private var feedMode: Int = 0
    @State private var searchText: String = ""
    var group: PlayersGroup
    @State private var groupPlayers: [User] = .init()
    
    private func filterSearch(allAttempts: [Attempt], searchText: String) -> [Attempt] {
        let groupAttempts = allAttempts.filter { group.player_ids.contains($0.player_id) }
        if searchText == "" {
            return groupAttempts
        } else {
            return groupAttempts.filter { $0.technique_name.contains(searchText) }
        }
    }
    
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
                    
                    Picker("", selection: $feedMode) {
                        Text("Members").tag(0)
                        Text("Activity").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    if feedMode == 0 {
                        
                        HStack {
                            Text("Members (\(group.player_ids.count))")
                                .foregroundStyle(Color.theme.accent)
                                .font(.headline)
                                .padding()
                            Spacer()
                        }
                        
                        List(groupPlayers) { player in
                            PlayerCardView(player: player)
                                .background(NavigationLink("", destination: PlayerView(player: player))
                                    .opacity(0))
                        }
                        .listStyle(PlainListStyle())
                        
                        NavigationLink(destination: EditGroupMembersView(group: group).environmentObject(store)) {
                            Text("Edit Members")
                        }
                        Spacer()
                        
                    }
                    
                    if feedMode == 1 {
                        SearchBarView(promptText: "Search for an attempt...", searchText: $searchText)
                        
                        List(filterSearch(allAttempts: store.attempts, searchText: searchText)) { attempt in
                                AttemptCardView(attempt: attempt)
                                    .background(NavigationLink("",
                                                               destination: AttemptFeedView(attempt: attempt)
                                        .environmentObject(store))
                                        .opacity(0))
                            }
                            .listStyle(PlainListStyle())
                    }
                }
            }
        }
        .task {
            var allPlayers = await User.players
            self.groupPlayers = allPlayers.filter {group.player_ids.contains($0.id)}
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
