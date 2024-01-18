//
//  CoachPlayersViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import Foundation

class CoachPlayersViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var requestedPlayers: [Player] = []
    @Published var searchText: String = ""
    @Published var groups: [PlayersGroup] = []
    
    init() {
        fakePlayers()
        fakeRequestedPlayers()
        fakeGroups()
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
            Player(id: UUID(), name: "Lionel Messi", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Cristiano Ronaldo", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Shay Given", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Joel Matip", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Roger Federer", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Dirk Nowitzki", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Yaya Toure", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Dirk Kuyt", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Roy Keane", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Denis Irwin", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Jeff Hendrick", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Caoimhin Kelleher", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Nikola Jokic", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "John Wall", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Isiah Thomas", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Kyrie Irving", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Stephen Curry", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Anthony Davis", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Jason Williams", email: "", profilePhoto: "player"),
        ]
    }
    
    func fakeRequestedPlayers() {
        self.requestedPlayers = [
            Player(id: UUID(), name: "David Beckham", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Didier Drogba", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Andy Roddick", email: "", profilePhoto: "player"),
            Player(id: UUID(), name: "Mo Farah", email: "", profilePhoto: "player"),
        ]
    }
    
    func fakeGroups() {
        self.groups = [
            PlayersGroup(id: UUID(), name: "Football", members: [
                Player(id: UUID(), name: "Lionel Messi", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Cristiano Ronaldo", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Shay Given", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Yaya Toure", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Dirk Kuyt", email: "", profilePhoto: "player"),
            ]),
            PlayersGroup(id: UUID(), name: "Irish", members: [
                Player(id: UUID(), name: "Shay Given", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Roy Keane", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Denis Irwin", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Jeff Hendrick", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Caoimhin Kelleher", email: "", profilePhoto: "player"),
            ]),
            PlayersGroup(id: UUID(), name: "NBA Players", members: [
                Player(id: UUID(), name: "Nikola Jokic", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "John Wall", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Isiah Thomas", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Kyrie Irving", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Stephen Curry", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Anthony Davis", email: "", profilePhoto: "player"),
                Player(id: UUID(), name: "Jason Williams", email: "", profilePhoto: "player"),
            ]),
        ]
    }
}
