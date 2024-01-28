//
//  CoachPlayerRequestsView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct CoachPlayerRequestsView: View {
    let requestedPlayers: [Player]
    @Binding var showRequests: Bool
    var body: some View {
        VStack {
            if !requestedPlayers.isEmpty {
                openRequests
                
                if showRequests {
                    requestedPlayersView
                }
            }
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

extension CoachPlayerRequestsView {
    private var requestedPlayersView: some View {
        VStack {
            ForEach(requestedPlayers, id: \.self) { player in
                HStack {
                    CirclePhotoView(url: player.image, size: 50)
                    Text(player.name)
                        .foregroundStyle(Color.theme.accent)
                    Spacer()
                    Button(action: {
                        print("accepting request")
//                        vm.acceptRequest(player: player)
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color.white)
                    }
                    .padding(12)
                    .background(Color.green)
                    .cornerRadius(10)
                    Button(action: {
                        print("rejecting request")
//                        vm.rejectRequest(player: player)
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
#Preview {
    CoachPlayerRequestsView(requestedPlayers: [], showRequests: .constant(true))
}
