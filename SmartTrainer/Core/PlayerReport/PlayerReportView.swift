//
//  PlayerReportView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 14/02/2024.
//

import SwiftUI

struct PlayerReportView: View {
    var body: some View {
        ScrollView {
            VStack {
                
                // basic user details -> name, image, email, date_created
                HStack {
                    
                    // profile image
                    Image("athlete")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                    
                    // basic details
                    VStack(alignment: .leading) {
                        Text("Jack O'Meara")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.theme.accent)
                            .padding(.top, 10)
                        
                        Text("jedomeara@gmail.com")
                            .foregroundStyle(Color.theme.accent)
                        
                        Spacer()
                        
                        Text("User since 07/01/2024")
                            .font(.caption)
                            .foregroundStyle(Color.theme.accent)
                    }
                    
                    Spacer()
                }
                .frame(height: 90)
                .padding(.bottom, 10)
                
                // overview text section for user
                VStack(alignment: .leading) {
                    Text("Overview")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    Text("Jack O'Meara is a consistent and moderately active user. He has demonstrated steady progress, aligning well with typical trajectories. In terms of performance, Jack consistently achieves slightly above-average scores, indicating a strong grasp of the techniques and potential for improvement.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.theme.secondaryText)
                }
                .padding(.bottom, 5)
                
                // activity chart section
                VStack(alignment: .leading) {
                    Text("Activity")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.gray.opacity(0.2)) // Adjust opacity and color as needed
                            .frame(height: 180) // Adjust size as needed
                            .containerRelativeFrame([.horizontal])
                        
                        // Text in the middle of the rectangle
                        Text("Activity chart will go here")
                            .foregroundColor(Color.theme.accent) // Adjust text color as needed
                            .font(.headline) // Adjust font and size as needed
                            .padding() // Add padding if needed
                            .multilineTextAlignment(.center) // Center text
                    }
                }
                .padding(.bottom, 5)
                
                // coach score summary
                VStack(alignment: .leading) {
                    Text("Coach Reviews")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    Text("Jack O'Meara is a consistent and moderately active user. He has demonstrated steady progress, aligning well with typical trajectories. In terms of performance, Jack consistently achieves slightly above-average scores, indicating a strong grasp of the techniques and potential for improvement.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.theme.secondaryText)
                }
                .padding(.bottom, 5)
                
                // ratings chart section
                VStack(alignment: .leading) {
                    Text("Ratings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.gray.opacity(0.2)) // Adjust opacity and color as needed
                            .frame(height: 180) // Adjust size as needed
                            .containerRelativeFrame([.horizontal])
                        
                        // Text in the middle of the rectangle
                        Text("Coach ratings chart will go here")
                            .foregroundColor(Color.theme.accent) // Adjust text color as needed
                            .font(.headline) // Adjust font and size as needed
                            .padding() // Add padding if needed
                            .multilineTextAlignment(.center) // Center text
                    }
                }
                .padding(.bottom, 5)
                
                // ai grades summary
                VStack(alignment: .leading) {
                    Text("AI Grades")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    Text("Jack O'Meara is a consistent and moderately active user. He has demonstrated steady progress, aligning well with typical trajectories. In terms of performance, Jack consistently achieves slightly above-average scores, indicating a strong grasp of the techniques and potential for improvement.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.theme.secondaryText)
                }
                .padding(.bottom, 5)
                
                // ratings chart section
                VStack(alignment: .leading) {
                    Text("Metrics")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.gray.opacity(0.2)) // Adjust opacity and color as needed
                            .frame(height: 180) // Adjust size as needed
                            .containerRelativeFrame([.horizontal])
                        
                        // Text in the middle of the rectangle
                        Text("AI grades chart will go here")
                            .foregroundColor(Color.theme.accent) // Adjust text color as needed
                            .font(.headline) // Adjust font and size as needed
                            .padding() // Add padding if needed
                            .multilineTextAlignment(.center) // Center text
                    }
                }
                .padding(.bottom, 5)
                
                Spacer()
            }
        }
    }
}

#Preview {
    PlayerReportView()
}
