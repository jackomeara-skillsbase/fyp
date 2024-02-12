//
//  TechniqueCardView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct TechniqueCardView: View {
    let technique: Technique
    let color: Color
    
    var body: some View {
        VStack {
            
            Image(technique.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipped()
                .padding()
            
            Text(technique.techniqueName)
                .padding(.bottom)
                .foregroundStyle(Color.white)
                
        }
        .background(color)
        .cornerRadius(15)
        .shadow(color: color.opacity(0.5), radius: 20, x:0, y:0)
    }
}

#Preview {
    TechniqueCardView(technique: Technique(id: UUID().uuidString, techniqueName: "Back Squat", videoURL: "back_squat", description: "Parallel depth, knees and hips aligned", aiModel: "sdf", thumbnail: "back_squat"), color: Color.cyan)
}
