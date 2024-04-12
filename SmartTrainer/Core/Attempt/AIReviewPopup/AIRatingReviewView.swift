//
//  AIRatingReview.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 31/01/2024.
//

import SwiftUI

struct AIRatingReviewView: View {
    var title: String = ""
    var rating: Int = 0
    
    let successColor: Color = .green
    let emptyColor: Color = .gray
    
    init(title: String, rating: String) {
        self.title = title
        self.rating = getIntForRating(rating: rating)
    }
    
    func getColor(rating: Int) -> Color {
        switch rating {
        case 0:
            return Color.red
        case 1:
            return Color.yellow
        case 2:
            return Color.green
        default:
            return Color.green
        }
    }
    
    private func getIntForRating(rating: String) -> Int {
        switch rating {
        case "poor":
            return 0
        case "average":
            return 1
        case "good":
            return 2
        default: return 0
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
            AIRatingReviewView(title: "Depth", rating: "")
            AIRatingReviewView(title: "Control", rating: "")
            AIRatingReviewView(title: "Balance", rating: "")
            AIRatingReviewView(title: "Other", rating: "")
        }
    }
}
