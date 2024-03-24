//
//  ManagerOverviewView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/03/2024.
//

import SwiftUI

struct ManagerOverviewView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Jack's Team")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.theme.accent)
                    Spacer()
                    CircleButtonView(iconName: "arrow.clockwise")
                        .rotationEffect(.degrees(90))
                }
                .padding()
                ManagerActivityChart()
                ManagerStatCardView(title: "Players", icon: "person", value:127, lastWeekValue: 112)
                ManagerStatCardView(title: "Coaches", icon: "person", value: 9, lastWeekValue: 7)
                Spacer()
            }
        }
    }
}

#Preview {
    ManagerOverviewView()
}
