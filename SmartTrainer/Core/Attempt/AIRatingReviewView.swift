//
//  AIRatingReview.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 31/01/2024.
//

import SwiftUI

struct AIRatingReviewView: View {
    let title: String
    let rating: Int
    
    let successColor: Color = .green
    let emptyColor: Color = .gray
    
    var body: some View {
        VStack {
            Text(title)
            
            VStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(successColor)
                        .frame(width: 15, height: 8)
                    
                    Circle()
                        .fill(successColor)
                        .frame(width: 30, height: 30)
                    
                    Rectangle()
                        .fill(rating > 0 ? successColor : emptyColor)
                        .frame(width: 50, height: 8)
                    
                    Circle()
                        .fill(rating > 0 ? successColor : emptyColor)
                        .frame(width: 30, height: 30)
                    
                    Rectangle()
                        .fill(rating > 1 ? successColor : emptyColor)
                        .frame(width: 50, height: 8)
                    
                    Circle()
                        .fill(rating > 1 ? successColor : emptyColor)
                        .frame(width: 30, height: 30)
                    
                    Rectangle()
                        .fill(rating == 2 ? successColor : emptyColor)
                        .frame(width: 15, height: 8)
                }
                .frame(height: 20)
                .padding(.vertical, 6)
                
                HStack {
                    Text("Poor")
                        .padding(.horizontal, 22)
                        .font(.subheadline)
                        .foregroundStyle(.accent)
                    
                    Text("OK")
                        .padding(.horizontal, 22)
                        .font(.subheadline)
                        .foregroundStyle(.accent)
                    
                    Text("Great")
                        .padding(.horizontal, 22)
                        .font(.subheadline)
                        .foregroundStyle(.accent)
                }
            }
        }
    }
}

struct AIRatingReviewView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AIRatingReviewView(title: "Depth", rating: 1)
            AIRatingReviewView(title: "Control", rating: 0)
            AIRatingReviewView(title: "Balance", rating: 2)
            AIRatingReviewView(title: "Other", rating: 1)
        }
    }
}
