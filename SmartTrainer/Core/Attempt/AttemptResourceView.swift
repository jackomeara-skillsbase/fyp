//
//  AttemptResource.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 31/01/2024.
//

import SwiftUI
import AVKit

struct AttemptResource: View {
    @State var isPlaying: Bool = false
    @State var showAI: Bool = false
    @State var showCoachReview: Bool = false
    private var player: AVLooperPlayer
    @EnvironmentObject private var store: Store
    var attempt: Attempt
    
    init(attempt: Attempt) {
        self.player = AVLooperPlayer(url: URL(string: attempt.video_url)!)
        self.attempt = attempt
    }
    
    var body: some View {
        if let currentUser = store.currentUser {
            ZStack {
                CustomVideoPlayer(player: player)
                    .containerRelativeFrame([.horizontal, .vertical])
                    .onTapGesture {
                        if isPlaying {
                            player.pause()
                        } else {
                            player.play()
                        }
                        isPlaying.toggle()
                    }
                    .onDisappear {
                        player.pause()
                    }
                
                VStack {
                    Spacer()
                    
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(attempt.player_name)
                                .fontWeight(.semibold)
                            
                            Text(attempt.technique_name)
                        }
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        VStack(spacing: 30) {
                            
                            CirclePhotoView(url: "player", size: 64)
                            
                            Button {
                                showAI.toggle()
                            } label: {
                                Image(systemName: "desktopcomputer")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .foregroundStyle(.white)
                                    .shadow(color: .black, radius: 3)
                            }
                            .sheet(isPresented: $showAI) {
                                AIReviewView()
                                    .presentationDetents([.fraction(0.7)])
                            }
                            
                            Button {
                                showCoachReview.toggle()
                            } label: {
                                Image(systemName: "message.fill")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .foregroundStyle(.white)
                                    .shadow(color: .black, radius: 3)
                            }
                            .sheet(isPresented: $showCoachReview) {
                                CoachReviewView(showPanel: $showCoachReview, attempt: attempt)
                                    .presentationDetents([.fraction(0.7)])
                                    .environmentObject(store)
                            }
                            
                            if currentUser.isCoach {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(.white)
                                        .shadow(color: .black, radius: 3)
                                }
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    self.player.play()
                    isPlaying = true
                }
                
                if !isPlaying {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 80, height: 100)
                        .foregroundStyle(Color.white)
                        .opacity(0.7)
                        .shadow(color: Color.gray, radius: 10)
                }
            }
        }
    }
}

#Preview {
    AttemptResource(attempt: Attempt(id: "123", date: Date(), video_url: "sadf", player_name: "Jack", player_id: "123", technique_name: "Bakc Squat", technique_id: "asd"))
        .environmentObject(Store())
}
