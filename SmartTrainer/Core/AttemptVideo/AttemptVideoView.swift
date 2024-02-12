//
//  AttemptVideoView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 30/01/2024.
//

import SwiftUI
import AVKit

struct AttemptVideoView: View {
    let post: Int
    var player: AVLooperPlayer
    @State var isPlaying: Bool
    
    init(post: Int) {
        self.post = post
        self.player = AVLooperPlayer(url: Bundle.main.url(forResource: "squat_attempt", withExtension: "MOV")!)
        self.isPlaying = false
    }
    
    var body: some View {
        ZStack {
            CustomVideoPlayer(player: player)
                .containerRelativeFrame([.horizontal, .vertical])
                .onTapGesture {
                    if isPlaying {
                        player.pause()
                        isPlaying = false
                    } else {
                        player.play()
                        isPlaying = true
                    }
                }
            
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Jack O'Meara")
                            .fontWeight(.semibold)
                        
                        Text("Back Squat")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.accent)
                    
                    Spacer()
                    
                    VStack(spacing: 24) {
                        Circle()
                            .frame(width: 48, height: 48)
                            .foregroundStyle(.gray)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "desktopcomputer")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color.theme.accent)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "message.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color.theme.accent)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color.theme.accent)
                        }
                    }
                }
                .padding(.bottom, 80)
            }
            .padding()
        }
        .onAppear {
            player.play()
            isPlaying = true
        }
    }
}

#Preview {
    AttemptVideoView(post: 1)
}
