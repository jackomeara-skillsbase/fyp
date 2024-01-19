//
//  PlayerHomeViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var attempts: [Attempt] = []
    @Published var notifications: [Notification] = []
    @Published var role: String = "player"
    
    private var attemptDataService: AttemptDataService = AttemptDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
//        fakeAttempts()
        fakeNotifications()
        setupBindings()
        fetchAttempts()
    }
    
    private func setupBindings() {
        attemptDataService.$allAttempts
            .assign(to: \.attempts, on: self)
            .store(in: &cancellables)
    }
    
    private func fetchAttempts() {
        attemptDataService.getAttempts()
    }
    
    func fakeAttempts(){
        self.attempts = [
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Kobe Bryant", player_id: "12345", technique_name: "Back Squat", technique_id: "12414"),
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Michael Jordan", player_id: "12345", technique_name: "Back Squat", technique_id: "12414"),
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Kobe Bryant", player_id: "12345", technique_name: "Push Up", technique_id: "12414"),
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Cristiano Ronaldo", player_id: "12345", technique_name: "Sit Up", technique_id: "12414"),
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Barry Bonds", player_id: "12345", technique_name: "Back Squat", technique_id: "12414"),
        ]
    }
    
    func fakeNotifications() {
        self.notifications = [
            Notification(id: 123, date: Date(), is_player: true, subject_id: 1, message: "Someone viewed your something"),
            Notification(id: 12, date: Date(), is_player: true, subject_id: 1, message: "Someone viewed your something"),
            Notification(id: 1, date: Date(), is_player: true, subject_id: 1, message: "Someone viewed your something"),
            Notification(id: 23, date: Date(), is_player: true, subject_id: 1, message: "Someone viewed your something"),
            Notification(id: 13, date: Date(), is_player: true, subject_id: 1, message: "Someone viewed your something"),
        ]
    }
}
