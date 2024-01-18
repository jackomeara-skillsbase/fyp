//
//  PlayerViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import Foundation

class PlayerViewModel: ObservableObject {
    @Published var attempts: [Attempt] = []
    
    init() {
        fakeAttempts()
    }
    
    func fakeAttempts() {
        self.attempts = [
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Kobe Bryant", player_id: "12345", technique_name: "Back Squat", technique_id: "12414"),
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Michael Jordan", player_id: "12345", technique_name: "Back Squat", technique_id: "12414"),
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Kobe Bryant", player_id: "12345", technique_name: "Push Up", technique_id: "12414"),
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Cristiano Ronaldo", player_id: "12345", technique_name: "Sit Up", technique_id: "12414"),
            Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Barry Bonds", player_id: "12345", technique_name: "Back Squat", technique_id: "12414"),
        ]
    }
}
