//
//  PlayerProfileViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import Foundation

class PlayerProfileViewModel: ObservableObject {
    @Published var coaches: [Coach] = []
    @Published var searchText: String = ""
    
    init() {
        fakeCoaches()
    }
    
    func fakeCoaches() {
        self.coaches = [
            Coach(id: UUID(), name: "Sean Dyche", profilePhoto: "coach"),
            Coach(id: UUID(), name: "Deion Sanders", profilePhoto: "coach")
        ]
    }
}
