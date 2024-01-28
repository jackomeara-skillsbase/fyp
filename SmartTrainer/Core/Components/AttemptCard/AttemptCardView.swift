//
//  AttemptCard.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct AttemptCardView: View {
    let attempt: Attempt
    
    func getAIScoreColor(score: String) -> Color {
        var scores = [String: Color]()
        scores["A"] = Color.green
        scores["B"] = Color.green
        scores["C"] = Color.yellow
        scores["D"] = Color.yellow
        scores["E"] = Color.red
        scores["F"] = Color.red
        
        return scores[score]!
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(attempt.technique_name)
                    .foregroundStyle(Color.theme.accent)
                    .font(.headline)
                Text(attempt.player_name)
                    .foregroundStyle(Color.theme.accent)
                    .font(.subheadline)
                Text("3 days ago")
                    .foregroundStyle(Color.theme.secondaryText)
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                HStack {
                    Image(systemName: "desktopcomputer")
                        .resizable()
                        .foregroundStyle(Color.theme.accent)
                        .frame(width: 25, height: 25)
                    Spacer()
                    Text(attempt.ai_review)
                        .foregroundStyle(getAIScoreColor(score: attempt.ai_review))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title)
                }
                .frame(width: 60)
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.theme.accent)
                    Spacer()
                    Image(systemName: attempt.coach_review == 0 ? "xmark" : "checkmark")
                        .resizable()
                        .foregroundStyle(attempt.coach_review == 0 ? Color.red : Color.green)
                        .frame(width: 20, height: 20)
                        
                }
                .frame(width: 60)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x:0.0, y:0.0
                )
        )
    }
}

struct AttemptCardView_Previews: PreviewProvider {
    static var previews: some View {
        AttemptCardView(attempt: self.dev.attempt)
    }
}
