//
//  NewGroupView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 22/01/2024.
//

import SwiftUI

struct NewGroupView: View {
    @Binding var showPopup: Bool
    var players: [User]
    @Binding var groups: [PlayersGroup]
    @State private var playerAdded: [Bool] = []
    @State private var nameText: String = ""
    @EnvironmentObject private var store: Store
    
    var body: some View {
        VStack {
            HStack {
                Text("New Group")
                    .foregroundStyle(Color.theme.accent)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                CircleButtonView(iconName: "xmark")
                    .onTapGesture {
                        showPopup = false
                    }
            }
            .padding(.horizontal)
            .padding(.top)
            
            SearchBarView(promptText: "Enter the group's name..", searchText: $nameText)
            
            List(playerAdded.indices, id:\.self) {index in
                HStack {
                    Text(players[index].name)
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
                    let group = 
                    try await store.createGroup(name: nameText, players: ids)
                    groups.append(group!)
                    showPopup = false
                }
                
            } label: {
                Text("Create")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            
            
        }
        .background(Color.theme.background)
        .cornerRadius(15)
        .padding()
        .frame(minHeight: 500)
        .onAppear {
            playerAdded = players.map { _ in false }
            print(players)
            print(playerAdded)
        }
    }
}

#Preview {
    NewGroupView(showPopup: .constant(true), players: [
        User(id: "1", name: "Player 1", email: "dsf", role: userRole.player, image_url: ""),
        User(id: "2", name: "Player 2", email: "asd", role: userRole.player, image_url: ""),
        User(id: "3", name: "Player 3", email: "dsd", role: userRole.player, image_url: ""),
    ], groups: .constant([]))
}
