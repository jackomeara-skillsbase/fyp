//
//  CoachPlayersViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import Foundation
import Combine

class CoachPlayersViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var requestedPlayers: [Player] = []
    @Published var searchText: String = ""
    @Published var groups: [PlayersGroup] = []
    
    private var playerDataService: PlayerDataService = PlayerDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupBindings()
        fetchPlayers()
        fakeRequestedPlayers()
        fakeGroups()
    }
    
    private func setupBindings() {
        playerDataService.$allPlayers
            .assign(to: \.players, on: self)
            .store(in: &cancellables)
    }
    
    private func fetchPlayers() {
        playerDataService.getPlayers()
    }
    
    func acceptRequest(player: Player) {
        self.requestedPlayers.removeAll { $0 == player }
        self.players.append(player)
    }
    
    func rejectRequest(player: Player) {
        self.requestedPlayers.removeAll { $0 == player }
    }
    
    func fakePlayers() {
        self.players = [
            Player(id: 12345, name: "Lionel Messi", email: "", image: "player"),
            Player(id: 12345, name: "Cristiano Ronaldo", email: "", image: "player"),
            Player(id: 12345, name: "Shay Given", email: "", image: "player"),
            Player(id: 12345, name: "Joel Matip", email: "", image: "player"),
            Player(id: 12345, name: "Roger Federer", email: "", image: "player"),
            Player(id: 12345, name: "Dirk Nowitzki", email: "", image: "player"),
            Player(id: 12345, name: "Yaya Toure", email: "", image: "player"),
            Player(id: 12345, name: "Dirk Kuyt", email: "", image: "player"),
            Player(id: 12345, name: "Roy Keane", email: "", image: "player"),
            Player(id: 12345, name: "Denis Irwin", email: "", image: "player"),
            Player(id: 12345, name: "Jeff Hendrick", email: "", image: "player"),
            Player(id: 12345, name: "Caoimhin Kelleher", email: "", image: "player"),
            Player(id: 12345, name: "Nikola Jokic", email: "", image: "player"),
            Player(id: 12345, name: "John Wall", email: "", image: "player"),
            Player(id: 12345, name: "Isiah Thomas", email: "", image: "player"),
            Player(id: 12345, name: "Kyrie Irving", email: "", image: "player"),
            Player(id: 12345, name: "Stephen Curry", email: "", image: "player"),
            Player(id: 12345, name: "Anthony Davis", email: "", image: "player"),
            Player(id: 12345, name: "Jason Williams", email: "", image: "player"),
        ]
    }
    
    func fakeRequestedPlayers() {
        self.requestedPlayers = [
            Player(id: 12345, name: "David Beckham", email: "", image: "player"),
            Player(id: 12345, name: "Didier Drogba", email: "", image: "player"),
            Player(id: 12345, name: "Andy Roddick", email: "", image: "player"),
            Player(id: 12345, name: "Mo Farah", email: "", image: "player"),
        ]
    }
    
    func fakeGroups() {
        self.groups = [
            PlayersGroup(id: 1234, name: "Football", members: [
                Player(id: 1234, name: "Lionel Messi", email: "", image: "player"),
                Player(id: 1234, name: "Cristiano Ronaldo", email: "", image: "player"),
                Player(id: 1234, name: "Shay Given", email: "", image: "player"),
                Player(id: 1234, name: "Yaya Toure", email: "", image: "player"),
                Player(id: 1234, name: "Dirk Kuyt", email: "", image: "player"),
            ]),
            PlayersGroup(id: 1234, name: "Irish", members: [
                Player(id: 1234, name: "Shay Given", email: "", image: "player"),
                Player(id: 1234, name: "Roy Keane", email: "", image: "player"),
                Player(id: 1234, name: "Denis Irwin", email: "", image: "player"),
                Player(id: 1234, name: "Jeff Hendrick", email: "", image: "player"),
                Player(id: 1234, name: "Caoimhin Kelleher", email: "", image: "player"),
            ]),
            PlayersGroup(id: 1234, name: "NBA Players", members: [
                Player(id: 1234, name: "Nikola Jokic", email: "", image: "player"),
                Player(id: 1234, name: "John Wall", email: "", image: "player"),
                Player(id: 1234, name: "Isiah Thomas", email: "", image: "player"),
                Player(id: 1234, name: "Kyrie Irving", email: "", image: "player"),
                Player(id: 1234, name: "Stephen Curry", email: "", image: "player"),
                Player(id: 1234, name: "Anthony Davis", email: "", image: "player"),
                Player(id: 1234, name: "Jason Williams", email: "", image: "player"),
            ]),
        ]
    }
}
