//
//  AttemptRatingView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import SwiftUI

struct AttemptRatingView: View {
    @Binding var rating: Int
    var label: String = "Overall"
    var editable: Bool
    
    let offColor: Color = Color.gray
    let onColor: Color = Color.yellow
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(Color.theme.accent)
                .padding(.trailing)
            ForEach(1...5, id:\.self) { number in
                Button {
                    if editable {
                        rating = number
                    }
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if (number > rating) {
            return Image(systemName: "star")
        }
        else {
            return Image(systemName: "star.fill")
        }
    }
}

#Preview {
    AttemptRatingView(rating: .constant(4), editable: false)
}
