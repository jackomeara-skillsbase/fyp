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

//#Preview {
//    GroupCardView(group: PlayersGroup(id: 1234, name: "Football", members: [
//        Player(id: 1234, name: "Lionel Messi", email: "", image: "player"),
//        Player(id: 1234, name: "Cristiano Ronaldo", email: "", image: "player"),
//        Player(id: 1234, name: "Shay Given", email: "", image: "player"),
//        Player(id: 1234, name: "Yaya Toure", email: "", image: "player"),
//        Player(id: 1234, name: "Dirk Kuyt", email: "", image: "player"),
//    ]))
//}
