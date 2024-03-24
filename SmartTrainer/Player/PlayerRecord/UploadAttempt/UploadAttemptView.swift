//
//  UploadAttemptView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 20/03/2024.
//

import SwiftUI

struct UploadAttemptView: View {
    @State private var caption: String = ""
    @State var visibilityLevel: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Back Squat")
                .foregroundStyle(.accent)
                .font(.headline)
            
            HStack(alignment: .top) {
                Rectangle()
                    .foregroundStyle(.accent)
                    .frame(width: 120, height: 250)
                
                
                VStack {
                    TextField(text: $caption) {
                        Text("Add a caption...")
                            .foregroundStyle(.secondaryText)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                    )
                    .padding(.bottom)
                    
                    AttemptVisibilityView(visibilityLevel: visibilityLevel)
                    
                }
            }
            
            Button {
                
            } label: {
                HStack {
                    Text("Upload")
                        .foregroundStyle(.white)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    UploadAttemptView()
}
