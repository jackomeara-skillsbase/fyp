//
//  NoCoachReviewView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 16/04/2024.
//

import SwiftUI

struct NoCoachReviewView: View {
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .foregroundStyle(.red)
                .frame(width: 60, height: 60)
            Text("No Coach Review Found.")
                .bold()
                .padding(.top, 6)
            
            Spacer()
            
        }
    }
}

#Preview {
    NoCoachReviewView()
}
