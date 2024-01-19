//
//  ReviewAttemptView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import SwiftUI

struct ReviewAttemptView: View {
    @State var overallRating: Int = 0
    @State var balanceRating: Int = 0
    @State var depthRating: Int = 0
    @State var controlRating: Int = 0
    @State var freeText: String = ""
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                AttemptRatingView(rating: $overallRating, label: "Overall")
                AttemptRatingView(rating: $depthRating, label: "Depth")
                AttemptRatingView(rating: $balanceRating, label: "Balance")
                AttemptRatingView(rating: $controlRating, label: "Control")

                TextField("Other Feedback", text: $freeText)
            }
        }
    }
}

#Preview {
    ReviewAttemptView()
}
