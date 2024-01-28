//
//  CoachGroupViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import Foundation
import Combine

class CoachGroupViewModel: ObservableObject {  
    @Published var groups: [PlayersGroup] = []
    @Published var players: [Player] = []
    
    private var groupDataService: GroupDataService = GroupDataService()
    private var playerDataService: PlayerDataService = PlayerDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupBindings()
        fetchGroups()
        fetchPlayers()
    }
    
    func setupBindings() {
        groupDataService.$allGroups
            .assign(to: \.groups, on: self)
            .store(in: &cancellables)
        playerDataService.$allPlayers
            .assign(to: \.players, on: self)
            .store(in: &cancellables)
    }
    
    func fetchGroups() {
        groupDataService.getGroups()
    }
    
    func fetchPlayers() {
        playerDataService.getPlayers()
    }
    
    func inflateMembers(group: PlayersGroup) -> [Player] {
        let members = self.players.filter {group.members.contains(Member(id: Int($0.id)))}
        return members
    }
    
    
}
