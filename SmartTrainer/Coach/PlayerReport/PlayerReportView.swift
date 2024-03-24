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
                    
                    Text("Jack O'Meara has shown a noteworthy dedication to training, with a total of 12 exercise attempts, including an impressive 10 attempts in the last week alone. This recent surge in activity suggests a strong commitment to improvement and a focused effort to enhance his skills.")
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
                        
//                        // Text in the middle of the rectangle
//                        Text("Activity chart will go here")
//                            .foregroundColor(Color.theme.accent) // Adjust text color as needed
//                            .font(.headline) // Adjust font and size as needed
//                            .padding() // Add padding if needed
//                            .multilineTextAlignment(.center) // Center text
                        
                        ActivityChartView()
                    }
                }
                .padding(.bottom, 5)
                
                // coach score summary
                VStack(alignment: .leading) {
                    Text("Strengths")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    Text("Positively, Jack's performance has been recognized with high praise, especially highlighted by an average coach overall score of 4.6/5. His range and balance have particularly stood out, with both the coach and AI rating these aspects highly; an average coach range score of 4.6/5 and a 'great' AI balance score underline his exceptional abilities in these areas. It's also commendable that his efforts in range exercises have been recognized as 'great' by the AI system, indicating a significant strength in executing exercises with a wide variety of movements.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.theme.secondaryText)
                }
                .padding(.bottom, 5)
                
                // ratings chart section
                VStack(alignment: .leading) {
                    Text("Coach Ratings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.gray.opacity(0.2)) // Adjust opacity and color as needed
                            .frame(height: 180) // Adjust size as needed
                            .containerRelativeFrame([.horizontal])
                        
//                        // Text in the middle of the rectangle
//                        Text("Coach ratings chart will go here")
//                            .foregroundColor(Color.theme.accent) // Adjust text color as needed
//                            .font(.headline) // Adjust font and size as needed
//                            .padding() // Add padding if needed
//                            .multilineTextAlignment(.center) // Center text
                        
                        CoachScoresChartView()
                    }
                }
                .padding(.bottom, 5)
                
                // ai grades summary
                VStack(alignment: .leading) {
                    Text("Areas to Improve")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    Text("However, while Jack's control has been deemed satisfactory ('OK' by the AI and an average coach control score of 4.1/5), there's room for improvement compared to his other stellar ratings. Enhancing his precision and consistency in control-related exercises could bring his skills to an even higher level. Focusing on drills that target fine motor skills and engaging in activities that require meticulous attention to technique might help in elevating his control to match his exceptional balance and range capabilities.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.theme.secondaryText)
                }
                .padding(.bottom, 5)
                
                // ratings chart section
                VStack(alignment: .leading) {
                    Text("AI Ratings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                        .padding(.bottom, 5)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.gray.opacity(0.2)) // Adjust opacity and color as needed
                            .frame(height: 180) // Adjust size as needed
                            .containerRelativeFrame([.horizontal])
                        
//                        // Text in the middle of the rectangle
//                        Text("AI grades chart will go here")
//                            .foregroundColor(Color.theme.accent) // Adjust text color as needed
//                            .font(.headline) // Adjust font and size as needed
//                            .padding() // Add padding if needed
//                            .multilineTextAlignment(.center) // Center text
                        
                        AIScoresChartView()
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
