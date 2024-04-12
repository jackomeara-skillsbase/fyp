//
//  TechniqueDetailsView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import SwiftUI

struct TechniqueDetailsView: View {
    @EnvironmentObject private var store: Store
    let technique: Technique
    @State private var player: AVLooperPlayer? = nil
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack(alignment: .leading) {
                
                if let player = player {
                    ZStack {
                        CustomVideoPlayer(player: player)
                            .frame(maxHeight: 400)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(technique.technique_name)
                                    .foregroundStyle(.white)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding()
                                Spacer()
                            }
                            .padding(.top, 340)
                        }
                    }
                }
                
                exerciseDescription
                
                Spacer()
                
                recordButton
            }
            .ignoresSafeArea(.container, edges: .top)
        }
        .onAppear {
            let url = Bundle.main.url(forResource: technique.video_url, withExtension: "mp4")!
            self.player = AVLooperPlayer(url: url)
            self.player?.play()
        }
        .onDisappear {
            self.player?.pause()
            self.player = nil
        }
    }
}

extension TechniqueDetailsView {
    private var exerciseDescription: some View {
        VStack {
            Text("\(technique.description)\n\nRecord one repetition. Film in portrait mode. Try to keep the phone still.")
        }
        .padding()
        .foregroundStyle(.secondaryText)
            
    }
}

extension TechniqueDetailsView {
    private var recordButton: some View {
        HStack {
            Spacer()
            NavigationLink(destination: RecordAttemptView(technique: technique)) {
                HStack {
                    Spacer()
                    Text("Record Attempt")
                            .foregroundStyle(Color.white)
                        .padding(.horizontal)
                    Spacer()
                }
            }
            .padding()
            .background(.blue)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    TechniqueDetailsView(technique: Technique(id: UUID().uuidString, technique_name: "Back Squat", video_url: "back_squat", description: "Start with your feet at least shoulder-width apart. In a controlled manner, squat down until your legs are at least parallel with the ground. Pause shortly at the bottom, before standing back up to complete the exercise. You can put your hands out for balance as you complete the exercise.", ai_model: "ai_model123", thumbnail: "back_squat"))
}
