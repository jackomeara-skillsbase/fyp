//
//  CoachPlayersView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct CoachPlayersView: View {
    @EnvironmentObject private var store: Store
    
    @State private var showGroups: Bool = false
    @State private var showRequests: Bool = false
    @State private var newGroup: Bool = false
    @State private var searchText: String = ""

    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            NavigationStack {
                VStack {
                    header
                    
                    if !showGroups {
                        CoachPlayerRequestsView(requestedPlayers: [], showRequests: $showRequests)
                        
                        SearchBarView(promptText: "Search for a player..", searchText: $searchText)
                        
                        List(searchText == "" ? store.players : store.players.filter { $0.name.contains(searchText) }) { player in
                            PlayerCardView(player: player)
                                .background(NavigationLink("", destination: PlayerView(player: player).environmentObject(store))
                                    .opacity(0))
                        }
                        .listStyle(PlainListStyle())
                    } else {
                        SearchBarView(promptText: "Search for a group..", searchText: $searchText)
                        
                        List(searchText == "" ? store.groups : store.groups.filter { $0.name.contains(searchText) }) { group in
                            GroupCardView(group: group)
                                .background(NavigationLink("", destination: CoachGroupView(group: group))
                                    .opacity(0))
                        }
                        .listStyle(PlainListStyle())
                    }
                    
                    Spacer()
                }
            }
            
            if newGroup {
                // background to disable content behind popup
                Color.theme.secondaryText.opacity(0.7)
                    .ignoresSafeArea()
                
                NewGroupView(showPopup: $newGroup, players: store.players)
            }
        }
    }
}

extension CoachPlayersView {
    private var header: some View {
        HStack {
            CircleButtonView(iconName: showGroups ? "plus" : "arrow.clockwise")
                .rotationEffect(.degrees(showGroups ? 0 : 90))
                .onTapGesture {
                    newGroup = true
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
