//
//  ToolPickerView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 24/03/2024.
//

import SwiftUI

struct ToolPickerView: View {
    @Binding var showColours: Bool
    @Binding var currentTool: String
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack {
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.top)
                .foregroundStyle(currentTool == "pencil" ? selectedColor : .white)
                .onTapGesture {
                    showColours = true
                    currentTool = "pencil"
                }
            Image(systemName: "line.diagonal")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.top)
                .foregroundStyle(currentTool == "line.diagonal" ? selectedColor : .white)
                .onTapGesture {
                    showColours = true
                    currentTool = "line.diagonal"
                }
            Image(systemName: "square")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.top)
                .padding(.bottom)
                .foregroundStyle(currentTool == "square" ? selectedColor : .white)
                .onTapGesture {
                    showColours = true
                    currentTool = "square"
                }
        }
        .padding(.horizontal, 10)
        .background(RoundedRectangle(cornerRadius: 25).fill(.black.opacity(0.2)))
    }
}

#Preview {
    HStack {
        Spacer()
        VStack {
            ToolPickerView(showColours: .constant(false), currentTool: .constant("pencil"), selectedColor: .constant(.green))
            Spacer()
        }
    }
    .padding()
}
