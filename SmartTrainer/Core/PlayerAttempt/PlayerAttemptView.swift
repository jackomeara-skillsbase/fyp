//
//  PlayerAttemptView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI
import AVKit

struct PlayerAttemptView: View {
    @EnvironmentObject private var store: Store
    @State var coachFeedback: String = ""
    let attempt: Attempt
    let coachReviewData: CoachReview = CoachReview(id: 1, date: Date(), overall: 4, depth: 3, range: 4, control: 5, comments: "Overall good attempt.")
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            NavigationStack {
                VStack(alignment: .leading)  {
                
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

                        ScrollView {
                            if store.role == "coach" {
                                coachReview
                            } else {
                                playerCoachReview
                            }
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("AI Review")
                                        .foregroundStyle(Color.theme.accent)
                                        .font(.headline)
                                    Spacer()
                                }
                            }
                            .padding()
                            Spacer()
                    }
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
        VStack {
            Text("Coach's Review")
                .padding()
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
            
            ReviewAttemptView()
            
            TextField("Other Feedback", text: $coachFeedback)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
            }
        }
    }
}

extension PlayerAttemptView {
    private var playerCoachReview: some View {
        VStack {
            Text("Coach's Review")
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
                .padding()
            StarReviewView(label: "Overall", score: coachReviewData.overall)
            StarReviewView(label: "Range", score: coachReviewData.range)
            StarReviewView(label: "Depth", score: coachReviewData.depth)
            StarReviewView(label: "Control", score: coachReviewData.control)
            HStack {
                Text(coachReviewData.comments)
                    .padding()
                .foregroundStyle(Color.theme.accent)
                Spacer()
            }

        }
    }
}

struct PlayerAttemptView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerAttemptView(attempt: self.dev.attempt)
    }
}
