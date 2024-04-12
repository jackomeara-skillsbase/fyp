//
//  CoachPlayersView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct CoachPlayersView: View {
    @EnvironmentObject private var store: Store
    
    @State private var groups: [PlayersGroup] = .init()
    @State private var players: [User] = .init()
    
    @State private var showGroups: Bool = false
    @State private var showRequests: Bool = false
    @State private var newGroup: Bool = false
    @State private var searchText: String = ""
    
    @State private var rotationAngle: Double = 0

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                VStack {
                    header
                    
                    if !showGroups {
                        CoachPlayerRequestsView(showRequests: $showRequests)
                            .environmentObject(store)
                        
                        SearchBarView(promptText: "Search for a player..", searchText: $searchText)
                        
                        List(searchText == "" ? players : players.filter { $0.name.contains(searchText) }) { player in
                            PlayerCardView(player: player)
                                .background(NavigationLink("", destination: PlayerView(player: player).environmentObject(store))
                                    .opacity(0))
                        }
                        .listStyle(PlainListStyle())
                    } else {
                        SearchBarView(promptText: "Search for a group..", searchText: $searchText)
                        
                        List(searchText == "" ? groups : groups.filter { $0.name.contains(searchText) }) { group in
                            GroupCardView(group: group)
                                .background(NavigationLink("", destination: CoachGroupView(group: group))
                                    .opacity(0))
                        }
                        .listStyle(PlainListStyle())
                    }
                    
                    Spacer()
                }
                
                if newGroup {
                    // background to disable content behind popup
                    Color.theme.secondaryText.opacity(0.7)
                        .ignoresSafeArea()
                    
                    NewGroupView(showPopup: $newGroup, players: players)
                        .environmentObject(store)
                }
            }
            .task {
                self.groups = await PlayersGroup.all
                self.players = await User.players
            }
        }
    }
}

extension CoachPlayersView {
    private var header: some View {
        HStack {
            CircleButtonView(iconName: showGroups ? "plus" : "arrow.clockwise")
                .rotationEffect(.degrees(showGroups ? 0 : rotationAngle))
                .onTapGesture {
                    showGroups ? newGroup = true :
                    withAnimation(Animation.linear(duration: 1)) {
                        rotationAngle = 360
                        Task {
                            self.players = await User.players
                        }
                    }
                }
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
                        searchText = ""
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
