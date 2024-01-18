//
//  GroupCardView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct GroupCardView: View {
    let group: PlayersGroup
    var body: some View {
        HStack {
            Text(group.name)
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
            Spacer()
            Text("\(group.members.count)")
                .foregroundStyle(Color.theme.accent)
            Image(systemName: "person")
                .foregroundStyle(Color.theme.accent)
        }
        .padding()
    }
}

#Preview {
    GroupCardView(group: PlayersGroup(id: UUID(), name: "Football", members: [
        Player(id: UUID(), name: "Lionel Messi", email: "", profilePhoto: "player"),
        Player(id: UUID(), name: "Cristiano Ronaldo", email: "", profilePhoto: "player"),
        Player(id: UUID(), name: "Shay Given", email: "", profilePhoto: "player"),
        Player(id: UUID(), name: "Yaya Toure", email: "", profilePhoto: "player"),
        Player(id: UUID(), name: "Dirk Kuyt", email: "", profilePhoto: "player"),
    ]))
}
