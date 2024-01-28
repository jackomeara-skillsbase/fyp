//
//  StaticAttemptReviewView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import SwiftUI

struct StaticAttemptReviewView: View {
    var overallRating
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                AttemptRatingView(rating: overallRating, label: "Overall")
                    .padding(.bottom)
                AttemptRatingView(rating: depthRating, label: "Range")
                    .padding(.bottom)
                AttemptRatingView(rating: balanceRating, label: "Balance")
                    .padding(.bottom)
                AttemptRatingView(rating: controlRating, label: "Control")
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    StaticAttemptReviewView()
}
