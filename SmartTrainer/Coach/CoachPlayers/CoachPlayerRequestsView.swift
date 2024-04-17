//
//  CoachPlayerRequestsView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct CoachPlayerRequestsView: View {
    @Binding var showRequests: Bool
    @State private var requestedPlayers: [User] = .init()
    @Binding var players: [User]
    
    var body: some View {
        VStack {
            if !requestedPlayers.isEmpty {
                openRequests
                
                if showRequests {
                    VStack {
                        ForEach(requestedPlayers) { player in
                            HStack {
                                CirclePhotoView(url: player.image_url, size: 50)
                                Text(player.name)
                                    .foregroundStyle(Color.theme.accent)
                                Spacer()
                                Button(action: {
                                    print("accepting request")
            //                        vm.acceptRequest(player: player)
                                    requestedPlayers.removeAll { $0.id == player.id}
                                    players.append(player)
                                    Task {
                                        try await RelationshipDataService.acceptPlayerRequest(playerID: player.id)
                                    }
                                }) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(Color.white)
                                }
                                .padding(12)
                                .background(Color.green)
                                .cornerRadius(10)
                                Button(action: {
                                    print("rejecting request")
                                    requestedPlayers.removeAll { $0.id == player.id}
            //                        vm.rejectRequest(player: player)
                                    Task {
                                        try await RelationshipDataService.rejectPlayerRequest(playerID: player.id)
                                    }
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundStyle(Color.white)
                                }
                                .padding(12)
                                .background(Color.red)
                                .cornerRadius(10)
                            }
                            .padding()
                            .background(Color.theme.background)
                            .cornerRadius(10)
                            .shadow(color: Color.theme.accent.opacity(0.3), radius: 5, x:0, y:0)
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .task {
            self.requestedPlayers = await User.requestedPlayers
        }
    }
}

extension CoachPlayerRequestsView {
    private var openRequests: some View {
        HStack {
            Text("\(requestedPlayers.count) pending requests")
                .foregroundStyle(Color.theme.accent)
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundStyle(Color.theme.accent)
                .rotationEffect(Angle(degrees: showRequests ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showRequests.toggle()
                    }
                }
        }
        .padding()
        .background(Color.theme.background)
        .cornerRadius(10)
        .shadow(color: Color.theme.accent.opacity(0.3), radius: 5, x:0, y:0)
        .padding()
    }
}

#Preview {
    CoachPlayerRequestsView(showRequests: .constant(true), players: .constant([]))
}
