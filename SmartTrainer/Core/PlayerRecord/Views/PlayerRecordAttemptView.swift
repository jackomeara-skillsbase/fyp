//
//  PlayerRecordAttemptView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import SwiftUI

struct PlayerRecordAttemptView: View {
    let technique: Technique
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(technique.techniqueName)
                            .foregroundStyle(Color.theme.accent)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        Spacer()
                    }
                    
                    videoPreview
                    
                    exerciseDescription
                    
                    recordButton
                    
                    Spacer()
                }
            }
        }
    }
}

extension PlayerRecordAttemptView {
    private var videoPreview: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 180, height: 320)
            .padding(.horizontal)
    }
}

extension PlayerRecordAttemptView {
    private var exerciseDescription: some View {
        VStack {
            Text(technique.description)
                .foregroundStyle(Color.theme.accent)
                .padding(.bottom)
            Text("Record one repetition of this exercise. Film in portrait mode. Try to keep the phone reasonably still as you record.")
                .foregroundStyle(Color.theme.accent)
        }
        .padding()
            
    }
}

extension PlayerRecordAttemptView {
    private var recordButton: some View {
        HStack {
            Spacer()
            NavigationLink(destination: RecordingView()) {
                    Text("Record Attempt")
                        .foregroundStyle(Color.white)
                        .padding(.horizontal)
            }
            .padding()
            .background(Color.green)
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

#Preview {
    PlayerRecordAttemptView(technique: Technique(id: UUID(), techniqueName: "Back Squat", videoURL: "back_squat", description: "Start with your feet at least shoulder-width apart. In a controlled manner, squat down until your legs are at least parallel with the ground. Pause shortly at the bottom, before standing back up to complete the exercise. You can put your hands out for balance as you complete the exercise.", aiModel: "ai_model123", thumbnail: "back_squat"))
}
