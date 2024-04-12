//
//  NoAIReviewView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 01/04/2024.
//

import SwiftUI

struct NoAIReviewView: View {
    @EnvironmentObject private var store: Store
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .foregroundStyle(.red)
                .frame(width: 60, height: 60)
            Text("No AI Review Found.")
                .bold()
                .padding(.top, 6)
            
            Spacer()
            
            // retry review
            
        }
    }
}

#Preview {
    NoAIReviewView()
}
