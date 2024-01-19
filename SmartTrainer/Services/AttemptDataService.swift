//
//  AttemptDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 12/01/2024.
//

import Foundation
import Combine

class AttemptDataService {
    @Published var allAttempts: [Attempt] = []
    @Published var personalAttempts: [Attempt] = []
    
    var attemptSubscription: AnyCancellable?
    
    private struct AttemptResponse: Decodable {
        let data: [Attempt]
    }
    
    init() {
        getAttempts()
    }
    
    func getAttempts() {
        guard let url = URL(string: "http://ec2-54-170-28-60.eu-west-1.compute.amazonaws.com:8080/fyp/items/attempt") else { return }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        attemptSubscription = NetworkManager.download(url: url)
            .decode(type: AttemptResponse.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: {[weak self] (response) in
                self?.allAttempts = response.data
                if GlobalViewModel.shared.role == "player" {
                    self?.personalAttempts = response.data.filter { Int($0.player_id) == GlobalViewModel.shared.id }
                }
                self?.attemptSubscription?.cancel()
            })
    }
}
