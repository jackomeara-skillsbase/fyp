//
//  PlayerProfileViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import Foundation
import Combine

class PlayerProfileViewModel: ObservableObject {
    @Published var coaches: [Coach] = []
    @Published var searchText: String = ""
    @Published var attempts: [Attempt] = []
    
    private var attemptDataService: AttemptDataService = AttemptDataService()
    private var coachDataService: CoachDataService = CoachDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fakeCoaches()
        setupBindings()
        fetchAttempts()
    }
    
    private func setupBindings() {
        attemptDataService.$personalAttempts
            .assign(to: \.attempts, on: self)
            .store(in: &cancellables)
    }
    
    private func fetchAttempts() {
        attemptDataService.getAttempts()
    }
    
//    private func addCoach(coach: String) {
//        coachDataService.addCoach(coach: coach)
//    }
    
    func fakeCoaches() {
        self.coaches = [
            Coach(id: 123, name: "Sean Dyche", email: "email", image: "coach"),
            Coach(id: 234, name: "Deion Sanders", email: "email", image: "coach")
        ]
    }
}
