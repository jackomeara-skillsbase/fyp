//
//  RolePickerView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 14/02/2024.
//

import SwiftUI

struct RolePickerView: View {
    @Binding var isCoach: Bool
    var body: some View {
        HStack {
            VStack {
                Image("athlete")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(!isCoach ? Color.blue : Color.clear, lineWidth: 3)
                    )
                    .onTapGesture {
                        isCoach.toggle()
                    }
                Text("Player")
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.horizontal)
            VStack {
                Image("coach")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(isCoach ? Color.blue : Color.clear, lineWidth: 3)
                    )
                    .onTapGesture {
                        isCoach.toggle()
                    }
                Text("Coach")
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    RolePickerView(isCoach: .constant(true))
}
