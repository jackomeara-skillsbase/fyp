//
//  PlayerRecordViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import Foundation

class PlayerRecordViewModel: ObservableObject {
    @Published var techniques: [Technique] = []
    
    init() {
        fakeTechniques()
    }
    
    func fakeTechniques() {
        self.techniques = [
            Technique(id: UUID(), techniqueName: "Back Squat", videoURL: "12345", description: "Start with your feet at least shoulder-width apart. In a controlled manner, squat down until your legs are at least parallel with the ground. Pause shortly at the bottom, before standing back up to complete the exercise. You can put your hands out for balance as you complete the exercise.", aiModel: "ai_backsquat", thumbnail: "back_squat"),
            Technique(id: UUID(), techniqueName: "Push Up", videoURL: "12345", description: "Place your palms on the ground, shoulder-width apart. Your toes should be the only other part of your body in contact with the ground. Lower yourself in a controlled manner without touching the ground, as low as possible. Pause for a moment, and slowly bring yourself back up to the starting position.", aiModel: "push_up_ai", thumbnail: "push_up"),
            Technique(id: UUID(), techniqueName: "Triangle Pose", videoURL: "triangle", description: "Stand with your feet wide apart, extend your arms parallel to the ground, and tilt your upper body sideways, reaching one hand towards the floor and the other towards the ceiling. Keep your gaze on the raised hand. Hold the position, breathe deeply, and switch sides.", aiModel: "123", thumbnail: "triangle_pose"),
            Technique(id: UUID(), techniqueName: "Pull Up", videoURL: "123", description: "Hang from the pull-up bar, grip shoulder-width apart, and pull your body up until your chin clears the bar. Lower down with control. ", aiModel: "123fsdrf", thumbnail: "pull_up")
        ]
    }
}
