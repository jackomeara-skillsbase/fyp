//
//  ColorPickerView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 14/01/2024.
//

import SwiftUI

struct ColorPickerView: View {
    let colors = [Color.red, Color.green, Color.purple, Color.yellow, Color.theme.accent]
    @Binding var selectedColor: Color
    var goBack: () -> Void
    var body: some View {
        HStack {
            Image(systemName: "arrow.turn.up.left")
                .foregroundColor(Color.theme.accent)
                .font(.system(size: 40))
                .onTapGesture {
                    goBack()
                }
                .padding(.horizontal)
            ForEach(colors, id: \.self) { color in
                Image(systemName: selectedColor == color ? "record.circle.fill" : "circle.fill")
                    .foregroundColor(color)
                    .font(.system(size: 40))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

#Preview {
    ColorPickerView(selectedColor: .constant(Color.red), goBack: {})
}
