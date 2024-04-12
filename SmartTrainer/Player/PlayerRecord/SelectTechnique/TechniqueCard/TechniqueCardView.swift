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
                .frame(width: 140, height: 140)
                .clipped()
                .padding()
            
            Text(technique.technique_name)
                .padding(.bottom)
                .foregroundStyle(Color.white)
                .font(.title3)
                
        }
        .background(color)
        .cornerRadius(15)
        .shadow(color: color.opacity(0.8), radius: 10, x:0, y:0)
        .padding([.horizontal, .bottom], 10)
    }
}

#Preview {
    TechniqueCardView(technique: Technique(id: UUID().uuidString, technique_name: "Back Squat", video_url: "back_squat", description: "Parallel depth, knees and hips aligned", ai_model: "sdf", thumbnail: "back_squat"), color: Color.cyan)
}

#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            ForEach(0..<4) { _ in
                TechniqueCardView(technique: Technique(id: UUID().uuidString, technique_name: "Back Squat", video_url: "back_squat", description: "Parallel depth, knees and hips aligned", ai_model: "sdf", thumbnail: "back_squat"), color: Color.cyan)
            }
        }
    }
}
