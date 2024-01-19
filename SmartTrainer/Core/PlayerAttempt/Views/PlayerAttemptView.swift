//
//  PlayerAttemptView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI
import AVKit

struct PlayerAttemptView: View {
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    let attempt: Attempt
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(attempt.technique_name)
                            .frame(alignment: .leading)
                            .foregroundStyle(Color.theme.accent)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                    }
                    
                    player
                    
                    videoPreview
                    
//                    if vm.role == "coach" {
                        coachReview
//                    }
                    
                    Spacer()
                }
            }
        }
    }
}

extension PlayerAttemptView {
    private var videoPreview: some View {
//        Rectangle()
//            .fill(Color.blue)
//            .frame(width: 180, height: 320)
//            .padding(.horizontal)

        VideoAutoplayView(videoFile: "squat_attempt", videoType: "MOV")
            .frame(maxHeight: 320)
    }
}

extension PlayerAttemptView {
    private var player: some View {
        HStack {
            CirclePhotoView(url: "coach")
            Text(attempt.player_name)
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
            Spacer()
            Text(attempt.date.toString(format: "dd/MM"))
                .foregroundStyle(Color.theme.secondaryText)
                .font(.subheadline)
        }
        .padding(.horizontal)
    }
}

extension PlayerAttemptView {
    private var coachReview: some View {
        ReviewAttemptView()
    }
}

struct PlayerAttemptView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerAttemptView(attempt: self.dev.attempt)
    }
}
