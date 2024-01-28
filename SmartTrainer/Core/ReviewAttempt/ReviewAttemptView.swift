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
                    .padding(.bottom)
                AttemptRatingView(rating: $depthRating, label: "Range")
                    .padding(.bottom)
                AttemptRatingView(rating: $balanceRating, label: "Balance")
                    .padding(.bottom)
                AttemptRatingView(rating: $controlRating, label: "Control")
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    ReviewAttemptView()
}
