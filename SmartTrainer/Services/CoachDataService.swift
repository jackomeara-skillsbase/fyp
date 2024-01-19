//
//  CoachDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import Foundation
import Combine

class CoachDataService {
    @Published var allCoaches: [Coach] = []
    
    var coachSubscription: AnyCancellable?
    
    private struct CoachResponse: Decodable {
        let data: [Coach]
    }
    
    init() {
        getCoaches()
    }
    
    func getCoaches() {
        guard let url = URL(string: "http://ec2-54-170-28-60.eu-west-1.compute.amazonaws.com:8080/fyp/items/coach") else {return}
        let decoder = JSONDecoder()
        
        coachSubscription = NetworkManager.download(url: url)
            .decode(type: CoachResponse.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: {[weak self] (response) in
                self?.allCoaches = response.data
                self?.coachSubscription?.cancel()
            })
    }
}

