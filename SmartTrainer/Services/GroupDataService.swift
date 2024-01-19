//
//  GroupDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 19/01/2024.
//

import Foundation
import Combine

class GroupDataService {
    @Published var allGroups: [PlayersGroup] = []
    
    var groupSubscription: AnyCancellable?
    
    private struct GroupResponse: Decodable {
        let data: [PlayersGroup]
    }
    
    init() {
        getGroups()
    }
    
    func getGroups() {
        guard let url = URL(string: "http://ec2-54-170-28-60.eu-west-1.compute.amazonaws.com:8080/fyp/items/relationship") else {return}
        let decoder = JSONDecoder()
        
        groupSubscription = NetworkManager.download(url: url)
            .decode(type: GroupResponse.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: {[weak self] (response) in
                self?.allGroups = response.data
                self?.groupSubscription?.cancel()
            })
    }
}
