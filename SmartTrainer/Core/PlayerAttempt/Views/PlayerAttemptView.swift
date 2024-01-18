//
//  PlayerAttemptView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI
import AVKit

struct PlayerAttemptView: View {
    let attempt: Attempt
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            ScrollView {
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
                    
                    Spacer()
                }
            }
        }
    }
}

extension PlayerAttemptView {
    private var videoPreview: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 180, height: 320)
            .padding(.horizontal)
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

struct PlayerAttemptView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerAttemptView(attempt: self.dev.attempt)
    }
}
