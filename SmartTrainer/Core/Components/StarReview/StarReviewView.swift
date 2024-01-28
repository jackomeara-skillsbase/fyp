//
//  StarReviewView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import SwiftUI

struct StarReviewView: View {
    var label: String
    var score: Int
    
    let offColor: Color = Color.gray
    let onColor: Color = Color.yellow
    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(Color.theme.accent)
                .padding(.horizontal)
            
            Spacer()
            
            ForEach(1...5, id:\.self) { number in
                image(for: number)
                    .foregroundStyle(number > score ? offColor : onColor)
            }

        }
    }
    
    func image(for number: Int) -> Image {
        if (number > score) {
            return Image(systemName: "star")
        }
        else {
            return Image(systemName: "star.fill")
        }
    }
}

#Preview {
    StarReviewView(label: "Overall", score: 4)
}
