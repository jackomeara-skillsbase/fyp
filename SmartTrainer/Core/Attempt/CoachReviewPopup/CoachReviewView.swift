//
//  CoachReviewView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 31/01/2024.
//

import SwiftUI

struct CoachReviewView: View {
    @State private var review: CoachReview? = nil
    @State var overallRating: Int = 0
    @State var formRating: Int = 0
    @State var rangeRating: Int = 0
    @State var controlRating: Int = 0
    @State var freeText: String = ""
    @Binding var showPanel: Bool
    @EnvironmentObject private var store: Store
    let attempt: Attempt
    @State private var isLoading: Bool = true
    
    var body: some View {
        if let currentUser = store.currentUser {
            ZStack {
                Color.theme.background
                
                VStack {
                    Text("Coach Review")
                        .padding()
                        .foregroundStyle(Color.theme.accent)
                        .font(.title2)
                    
                    if store.currentUser!.role == userRole.player && !isLoading && review == nil {
                        NoCoachReviewView()
                    }
                    else {
                        
                        AttemptRatingView(rating: $overallRating, label: "Overall", editable: currentUser.role == userRole.coach)
                            .padding(.bottom)
                        AttemptRatingView(rating: $rangeRating, label: "Range", editable: currentUser.role == userRole.coach)
                            .padding(.bottom)
                        AttemptRatingView(rating: $formRating, label: "Form", editable: currentUser.role == userRole.coach)
                            .padding(.bottom)
                        AttemptRatingView(rating: $controlRating, label: "Control", editable: currentUser.role == userRole.coach)
                            .padding(.bottom)
                        
                        if (currentUser.role == userRole.coach || !freeText.isEmpty) {
                            HStack {
                                Text("Comments:")
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        HStack {
                            if currentUser.role == userRole.coach {
                                TextEditor(text: $freeText)
                                    .frame(height: 100)
                                    .padding()
                                    .cornerRadius(15)
                                    .border(Color.gray.opacity(0.5), width: 1)
                            } else {
                                if !freeText.isEmpty {
                                    Text(freeText)
                                        .frame(height: 100)
                                        .padding()
                                        .cornerRadius(15)
                                        .border(Color.gray.opacity(0.5), width: 1)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        if currentUser.role == userRole.coach {
                            Button {
                                showPanel = false
                                let review = CoachReview(id: attempt.id, date: Date(), overall: overallRating, range: rangeRating, balance: formRating, control: controlRating, comments: freeText)
                                Task {
                                    try await CoachReviewDataService.reviewAttempt(review: review)
                                    try await AttemptDataService.confirmCoachReview(attemptID: attempt.id)
                                    try await NotificationDataService.createNotification(notification: Notification(id: UUID().uuidString, date: Date(), user_id: attempt.player_id, message: "\(store.currentUser!.name) has reviewed your \(attempt.technique_name) attempt"))
                                }
                            } label: {
                                Text("Save")
                            }
                        }
                        Spacer()
                    }
                }
            }
            .onAppear {
                Task {
                    self.review = try await CoachReviewDataService.getAttemptReview(attemptID: attempt.id)
                    if let review = self.review {
                        freeText = review.comments
                        formRating = review.form
                        controlRating = review.control
                        overallRating = review.overall
                        rangeRating = review.range
                    }
                    self.isLoading = false
                }
        }
        }
    }
}

#Preview {
    CoachReviewView(showPanel: .constant(true), attempt: Attempt(
        id: "123",
        date: Date(),
        caption: "",
        video_url: "back_squat",
        imgs: [],
        player_name: "Barry Bonds",
        player_id: "12345",
        technique_name: "Back Squat",
        technique_id: "12414",
        permissions: Attempt.PermissionLevel.priv,
        custom_permissions: nil,
        ai_reviewed: false,
        coach_reviewed: false
    ))
}
