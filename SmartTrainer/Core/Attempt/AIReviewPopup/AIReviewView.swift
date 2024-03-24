//
//  AIReviewView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 31/01/2024.
//

import SwiftUI

struct AIReviewView: View {
    var body: some View {
        ZStack {
            Color.theme.background
            
            VStack {
                Text("AI Review")
                    .padding()
                    .foregroundStyle(Color.theme.accent)
                    .font(.title2)
                
                AIRatingReviewView(title: "Depth", rating: 2)
                    .padding(.bottom)
                AIRatingReviewView(title: "Control", rating: 0)
                    .padding(.bottom)
                AIRatingReviewView(title: "Balance", rating: 1)
                    .padding(.bottom)
                
                Spacer()
            }
        }
    }
}

#Preview {
    AIReviewView()
}
