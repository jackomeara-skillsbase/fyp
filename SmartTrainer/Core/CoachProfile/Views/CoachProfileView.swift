//
//  CoachProfileView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct CoachProfileView: View {
    @EnvironmentObject private var hvm: HomeViewModel
    var body: some View {
        VStack {
            ProfileBaseView()
            Spacer()
            Button(action: {
                print("logging out..")
                hvm.role = "player"
            }) {
                Text("Log Out")
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.red)
            .cornerRadius(10)
        }
    }
}

#Preview {
    CoachProfileView()
}
