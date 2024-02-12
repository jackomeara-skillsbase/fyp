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
    @State private var playerAdded: [Bool] = []
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
            
            SearchBarView(promptText: "Enter the group's name..", searchText: .constant(""))
            
            List(playerAdded.indices, id:\.self) {index in
                HStack {
                    Text(players[index].name)
                    Spacer()
                    Toggle("", isOn: $playerAdded[index])
                }
            }
            .listStyle(PlainListStyle())
            
            Button("Create") {
//                var ids = []
//                for (index, value) in playerAdded.enumerated() {
//                    if value {
//                        ids.append(players[index].id)
//                    }
//                }
                
            }
            
            
        }
        .background(Color.theme.background)
        .cornerRadius(15)
        .padding()
        .frame(minHeight: 500)
        .onAppear {
            playerAdded = players.map { _ in false }
        }
    }
}

#Preview {
    NewGroupView(showPopup: .constant(true), players: [
        User(id: "1", name: "Player 1", email: "dsf", isCoach: false, image_url: ""),
        User(id: "2", name: "Player 2", email: "asd", isCoach: false, image_url: ""),
        User(id: "3", name: "Player 3", email: "dsd", isCoach: false, image_url: ""),
    ])
}
