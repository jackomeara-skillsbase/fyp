//
//  TechniqueDetailsView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import SwiftUI

struct TechniqueDetailsView: View {
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

extension TechniqueDetailsView {
    private var videoPreview: some View {
//        Rectangle()
//            .fill(Color.blue)
//            .frame(width: 180, height: 320)
//            .padding(.horizontal)
        VideoAutoplayView(videoFile: technique.videoURL)
            .frame(maxHeight: 320)
    }
}

extension TechniqueDetailsView {
    private var exerciseDescription: some View {
        VStack {
            Text("\(technique.description)\n\nRecord one repetition. Film in portrait mode. Try to keep the phone still.")
        }
        .padding()
        .foregroundStyle(Color.theme.accent)
            
    }
}

extension TechniqueDetailsView {
    private var recordButton: some View {
        HStack {
            Spacer()
            NavigationLink(destination: RecordAttemptView(technique: technique)) {
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
    TechniqueDetailsView(technique: Technique(id: UUID().uuidString, techniqueName: "Back Squat", videoURL: "back_squat", description: "Start with your feet at least shoulder-width apart. In a controlled manner, squat down until your legs are at least parallel with the ground. Pause shortly at the bottom, before standing back up to complete the exercise. You can put your hands out for balance as you complete the exercise.", aiModel: "ai_model123", thumbnail: "back_squat"))
}
