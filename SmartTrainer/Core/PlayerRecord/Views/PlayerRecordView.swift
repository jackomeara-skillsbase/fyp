//
//  PlayerRecordView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct PlayerRecordView: View {
    @StateObject var vm: PlayerRecordViewModel = PlayerRecordViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background layer
                Color.theme.background
                    .ignoresSafeArea()
                
                // content layer
                ScrollView {
                    VStack {
                        HStack {
                            Text("Time To\n")
                                .foregroundStyle(Color.theme.accent)
                                .font(.title2)
                            +
                            Text("Train.")
                                .foregroundStyle(Color.theme.accent)
                                .font(.largeTitle)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        .padding()
                        
                        exercises
                        
                        Spacer()
                        
                    }
                }
            }
        }
    }
}

extension PlayerRecordView {
    private var exercises: some View {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: PlayerRecordAttemptView(technique: vm.techniques[0])) {
                        TechniqueCardView(technique: vm.techniques[0], color: Color.red)
                    }
//                    TechniqueCardView(technique: vm.techniques[0], color: Color.red)
//                        .background(NavigationLink("", destination: PlayerRecordAttemptView(technique: vm.techniques[0]))
//                            .opacity(0))
                    Spacer()
                    NavigationLink(destination: PlayerRecordAttemptView(technique: vm.techniques[1])) {
                        TechniqueCardView(technique: vm.techniques[1], color: Color.green)
                    }
//                    TechniqueCardView(technique: vm.techniques[1], color: Color.green)
                    Spacer()
                }
                .padding(.vertical)
                HStack {
                    Spacer()                
                    NavigationLink(destination: PlayerRecordAttemptView(technique: vm.techniques[2])) {
                        TechniqueCardView(technique: vm.techniques[2], color: Color.yellow)
                    }
//                    TechniqueCardView(technique: vm.techniques[2], color: Color.yellow)
                    Spacer()
                    NavigationLink(destination: PlayerRecordAttemptView(technique: vm.techniques[3])) {
                        TechniqueCardView(technique: vm.techniques[3], color: Color.cyan)
                    }
//                    TechniqueCardView(technique: vm.techniques[3], color: Color.cyan)
                    Spacer()
            }
        }
    }
}

#Preview {
    PlayerRecordView()
}
