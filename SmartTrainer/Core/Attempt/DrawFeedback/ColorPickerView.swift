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
    @Binding var currentTool: String
    @Binding var showColours: Bool
    
    var body: some View {
        VStack {
//            Image(systemName: "arrow.turn.up.left")
//                .foregroundColor(Color.theme.accent)
//                .font(.system(size: 40))
//                .onTapGesture {
//                    goBack()
//                }
//                .padding(.horizontal)
            Image(systemName: currentTool)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(selectedColor)
                .padding(.top, 10)
                .onTapGesture {
                    showColours = false
                }
            
            ForEach(colors, id: \.self) { color in
                Image(systemName: selectedColor == color ? "record.circle.fill" : "circle.fill")
                    .foregroundColor(color)
                    .font(.system(size: 30))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                        showColours = false
                }
                    .padding(.bottom, 1)
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 6)
        .background(RoundedRectangle(cornerRadius: 25).fill(.black.opacity(0.2)))
    }
}

#Preview {
    ColorPickerView(selectedColor: .constant(Color.red), goBack: {}, currentTool: .constant("pencil"), showColours: .constant(true))
}
