//
//  Store.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 28/01/2024.
//

import Foundation
import Combine

@MainActor
class Store: ObservableObject {
    // user settings
    @Published var name: String = "Jack O'Meara"
    @Published var email: String = "jackomeara@gmail.com"
    @Published var id: Int = 1
    @Published var role: String = "player"
    @Published var authenticated: Bool = true
    
    // model data
    @Published var attempts: [Attempt] = []
    @Published var players: [Player] = []
    @Published var groups: [PlayersGroup] = []
    @Published var coaches: [Coach] = []
    @Published var notifications: [Notification] = []
    @Published var relationships: [Relationship] = []
    
    // data services and network variables
    private var cancellables: Set<AnyCancellable> = []
    private var attemptDataService: AttemptDataService = AttemptDataService()
    private var playerDataService: PlayerDataService = PlayerDataService()
    private var groupDataService: GroupDataService = GroupDataService()
    private var coachDataService: CoachDataService = CoachDataService()
    private var notificationDataService: NotificationDataService = NotificationDataService()
    private var relationshipDataService: RelationshipDataService = RelationshipDataService()
    
    init() {
        setupBindings()
    }
    
    // bind data services to published variables
    private func setupBindings() {
        attemptDataService.$allAttempts
            .assign(to: \.attempts, on: self)
            .store(in: &cancellables)
        playerDataService.$allPlayers
            .assign(to: \.players, on: self)
            .store(in: &cancellables)
        groupDataService.$allGroups
            .assign(to: \.groups, on: self)
            .store(in: &cancellables)
        coachDataService.$allCoaches
            .assign(to: \.coaches, on: self)
            .store(in: &cancellables)
        notificationDataService.$allNotifications
            .assign(to: \.notifications, on: self)
            .store(in: &cancellables)
        relationshipDataService.$allRelationships
            .assign(to: \.relationships, on: self)
            .store(in: &cancellables)
    }
    
    // inflate group members (array of ID's) to players
    func inflateGroupMembers(group: PlayersGroup) -> [Player] {
        return self.players.filter {group.members.contains(Member(id: Int($0.id)))}
    }
    
    // define methods to refresh data
    func fetchAttempts() { attemptDataService.getAttempts() }
    func fetchPlayers() { playerDataService.getPlayers() }
    func fetchGroups() { groupDataService.getGroups() }
    func fetchCoaches() { coachDataService.getCoaches() }
    func fetchNotifications() { notificationDataService.getNotifications() }
    func fetchRelationships() { relationshipDataService.getRelationships() }
}
