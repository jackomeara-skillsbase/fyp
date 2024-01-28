//
//  PlayerRecordView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct PlayerRecordView: View {
    
    private var techniques: [Technique] = [
        Technique(id: UUID(), techniqueName: "Back Squat", videoURL: "12345", description: "Start with your feet at least shoulder-width apart. In a controlled manner, squat down until your legs are at least parallel with the ground. Pause at the bottom, before standing back up. You can put your hands out for balance.", aiModel: "ai_backsquat", thumbnail: "back_squat"),
        Technique(id: UUID(), techniqueName: "Push Up", videoURL: "12345", description: "Place your palms on the ground, shoulder-width apart. Your toes should be the only other part of your body in contact with the ground. Lower yourself in a controlled manner without touching the ground, as low as possible. Pause and slowly bring yourself back up.", aiModel: "push_up_ai", thumbnail: "push_up"),
        Technique(id: UUID(), techniqueName: "Triangle Pose", videoURL: "triangle", description: "Stand with your feet wide apart, extend your arms parallel to the ground, and tilt your upper body sideways, reaching one hand towards the floor and the other towards the ceiling. Keep your gaze on the raised hand. .", aiModel: "123", thumbnail: "triangle_pose"),
        Technique(id: UUID(), techniqueName: "Pull Up", videoURL: "123", description: "Hang from the pull-up bar, grip shoulder-width apart, and pull your body up until your chin clears the bar. Lower down with control. ", aiModel: "123fsdrf", thumbnail: "pull_up")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background layer
                Color.theme.background
                    .ignoresSafeArea()
                
                // content layer
                ScrollView {
                    VStack {
                        HStack {
                            Text("Time To\n")
                                .foregroundStyle(Color.theme.accent)
                                .font(.title2)
                            +
                            Text("Train.")
                                .foregroundStyle(Color.theme.accent)
                                .font(.largeTitle)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        .padding()
                        
                        exercises
                        
                        Spacer()
                        
                    }
                }
            }
        }
    }
}

extension PlayerRecordView {
    private var exercises: some View {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: PlayerRecordAttemptView(technique: techniques[0])) {
                        TechniqueCardView(technique: techniques[0], color: Color.red)
                    }
                    Spacer()
                    NavigationLink(destination: PlayerRecordAttemptView(technique: techniques[1])) {
                        TechniqueCardView(technique: techniques[1], color: Color.green)
                    }
                    Spacer()
                }
                .padding(.vertical)
                HStack {
                    Spacer()                
                    NavigationLink(destination: PlayerRecordAttemptView(technique: techniques[2])) {
                        TechniqueCardView(technique: techniques[2], color: Color.yellow)
                    }
                    Spacer()
                    NavigationLink(destination: PlayerRecordAttemptView(technique: techniques[3])) {
                        TechniqueCardView(technique: techniques[3], color: Color.cyan)
                    }
                    Spacer()
            }
        }
    }
}

#Preview {
    PlayerRecordView()
}
