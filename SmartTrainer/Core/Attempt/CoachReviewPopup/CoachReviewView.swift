//
//  CoachReviewView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 31/01/2024.
//

import SwiftUI

struct CoachReviewView: View {
    @State var overallRating: Int = 0
    @State var balanceRating: Int = 0
    @State var rangeRating: Int = 0
    @State var controlRating: Int = 0
    @State var freeText: String = ""
    @Binding var showPanel: Bool
    @EnvironmentObject private var store: Store
    let attempt: Attempt
    
    var body: some View {
        if let currentUser = store.currentUser {
            ZStack {
                Color.theme.background
                
                VStack {
                    Text("Coach Review")
                        .padding()
                        .foregroundStyle(Color.theme.accent)
                        .font(.title2)
                                    
                    AttemptRatingView(rating: $overallRating, label: "Overall")
                        .padding(.bottom)
                    AttemptRatingView(rating: $rangeRating, label: "Range")
                        .padding(.bottom)
                    AttemptRatingView(rating: $balanceRating, label: "Balance")
                        .padding(.bottom)
                    AttemptRatingView(rating: $controlRating, label: "Control")
                        .padding(.bottom)
                    
                    HStack {
                        Text("Comments:")
                        Spacer()
                    }
                    .padding(.horizontal)
                    HStack {
                        TextEditor(text: $freeText)
                                        .frame(height: 100)
                                        .padding()
                                        .cornerRadius(15)
                                        .border(Color.gray.opacity(0.5), width: 1)
                    }
                    .padding(.horizontal)
                    
                    if currentUser.role == userRole.coach {
                        Button {
                            showPanel = false
                            let review = CoachReview(id: attempt.id, date: Date(), overall: overallRating, range: rangeRating, balance: balanceRating, control: controlRating, comments: freeText)
                            Task {
                                try await CoachReviewDataService.reviewAttempt(review: review)
                            }
                        } label: {
                            Text("Save")
                        }
                    }
                    Spacer()
                }
            }
            .onAppear {
                Task {
                    let review = try await CoachReviewDataService.getAttemptReview(attemptID: attempt.id)
                    if review != nil {
                        overallRating = review!.overall
                        balanceRating = review!.balance
                        controlRating = review!.control
                        rangeRating = review!.range
                        freeText = review!.comments
                    }
                }
        }
        }
    }
}

#Preview {
    CoachReviewView(showPanel: .constant(true), attempt: Attempt(id: "", date: Date(), video_url: "", player_name: "", player_id: "", technique_name: "", technique_id: ""))
}
