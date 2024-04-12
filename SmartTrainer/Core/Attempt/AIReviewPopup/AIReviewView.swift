//
//  AIReviewView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 31/01/2024.
//

import SwiftUI

struct AIReviewView: View {
    var attemptID: String
    @EnvironmentObject private var store: Store
    @State private var review: AIReview? = nil
    @State private var isLoaded: Bool = false
    
    // flag review details
    @State private var showFlagReview: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.theme.background
            
            VStack {
                Text("AI Review")
                    .padding()
                    .foregroundStyle(Color.theme.accent)
                    .font(.title2)
                
                if isLoaded {
                    if let review = review {
                        
                        AIRatingReviewView(title: "Depth", rating: review.range)
                            .padding(.bottom)
                        AIRatingReviewView(title: "Control", rating: review.control)
                            .padding(.bottom)
                        AIRatingReviewView(title: "Form", rating: review.form)
                            .padding(.bottom)
                        
                        // show coach flag review
                        if store.currentUser?.role == userRole.coach {
                            // if review is flagged, show that it has been flagged
                            FlagAIReview(review: review, isFlagged: review.flagged, showFlagReview: $showFlagReview)
                                .presentationDetents([.fraction(0.7)])
                                .environmentObject(store)
                        }
                        
                    } else {
                        NoAIReviewView()
                            .environmentObject(store)
                    }
                } else {
                    ProgressView()
                }
                
                Spacer()
                
            }
        }
        .onAppear {
            Task {
                self.review = try await AIReviewDataService.getAIReview(attemptID: attemptID)
                self.isLoaded = true
            }
        }
    }
}

#Preview {
    AIReviewView(attemptID: "")
}
