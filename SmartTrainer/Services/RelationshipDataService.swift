//
//  RelationshipDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import Foundation
import Combine

class RelationshipDataService {
    @Published var allRelationships: [Relationship] = []
    
    var relationshipSubscription: AnyCancellable?
    
    private struct RelationshipResponse: Decodable {
        let data: [Relationship]
    }
    
    init() {
        getRelationships()
    }
    
    func getRelationships() {
        guard let url = URL(string: "http://ec2-54-170-28-60.eu-west-1.compute.amazonaws.com:8080/fyp/items/relationship") else {return}
        let decoder = JSONDecoder()
        
        relationshipSubscription = NetworkManager.download(url: url)
            .decode(type: RelationshipResponse.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: {[weak self] (response) in
                self?.allRelationships = response.data
                self?.relationshipSubscription?.cancel()
            })
    }
}
