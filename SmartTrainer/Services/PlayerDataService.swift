//
//  PlayerDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import Foundation
import Combine

class PlayerDataService {
    @Published var allPlayers: [Player] = []
    
    var playerSubscription: AnyCancellable?
    
    private struct PlayerResponse: Decodable {
        let data: [Player]
    }
    
    init() {
        getPlayers()
    }
    
    func getPlayers() {
        guard let url = URL(string: "http://ec2-54-170-28-60.eu-west-1.compute.amazonaws.com:8080/fyp/items/player") else {return}
        let decoder = JSONDecoder()
        
        playerSubscription = NetworkManager.download(url: url)
            .decode(type: PlayerResponse.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: {[weak self] (response) in
                self?.allPlayers = response.data
                self?.playerSubscription?.cancel()
            })
    }
}
