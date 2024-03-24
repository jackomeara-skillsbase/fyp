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
    
    func getColor(rating: Int) -> Color {
        switch rating {
        case 0:
            return Color.red
        case 1:
            return Color.yellow
        case 2 :
            return Color.green
        default:
            return Color.green
        }
    }
    
    var body: some View {
        VStack {
            Text(title)
            
            VStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(getColor(rating: rating))
                        .frame(width: 15, height: 8)
                    
                    Circle()
                        .fill(getColor(rating: rating))
                        .frame(width: 30, height: 30)
                    
                    Rectangle()
                        .fill(rating > 0 ? getColor(rating: rating) : emptyColor)
                        .frame(width: 50, height: 8)
                    
                    Circle()
                        .fill(rating > 0 ? getColor(rating: rating) : emptyColor)
                        .frame(width: 30, height: 30)
                    
                    Rectangle()
                        .fill(rating > 1 ? getColor(rating: rating) : emptyColor)
                        .frame(width: 50, height: 8)
                    
                    Circle()
                        .fill(rating > 1 ? getColor(rating: rating) : emptyColor)
                        .frame(width: 30, height: 30)
                    
                    Rectangle()
                        .fill(rating == 2 ? getColor(rating: rating) : emptyColor)
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
