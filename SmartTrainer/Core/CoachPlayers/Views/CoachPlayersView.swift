//
//  CoachPlayersView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct CoachPlayersView: View {
    @StateObject private var vm: CoachPlayersViewModel = CoachPlayersViewModel()
    
    @State private var showGroups: Bool = false
    @State private var showRequests: Bool = false

    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            NavigationStack {
                VStack {
                    header
                    
                    if !showGroups {
                        CoachPlayerRequestsView(requestedPlayers: vm.requestedPlayers, vm: vm, showRequests: $showRequests)
                        
                        SearchBarView(promptText: "Search for a player..", searchText: $vm.searchText)
                        
                        List(vm.searchText == "" ? vm.players : vm.players.filter { $0.name.contains(vm.searchText) }) { player in
                            PlayerCardView(player: player)
                                .background(NavigationLink("", destination: PlayerView(player: player))
                                    .opacity(0))
                        }
                        .listStyle(PlainListStyle())
                    } else {
                        SearchBarView(promptText: "Search for a group..", searchText: $vm.searchText)
                        
                        List(vm.groups) { group in
                            GroupCardView(group: group)
                                .background(NavigationLink("", destination: Text(group.name))
                                    .opacity(0))
                        }
                        .listStyle(PlainListStyle())
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

extension CoachPlayersView {
    private var header: some View {
        HStack {
            CircleButtonView(iconName: "arrow.clockwise")
                .rotationEffect(.degrees(90))
            Spacer()
            Text(showGroups ? "Groups" : "Players")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: showGroups ? "person" : "person.3")
                .onTapGesture {
                    withAnimation(.spring()) {
                        showGroups.toggle()
                        showRequests = false
                    }
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CoachPlayersView()
}
