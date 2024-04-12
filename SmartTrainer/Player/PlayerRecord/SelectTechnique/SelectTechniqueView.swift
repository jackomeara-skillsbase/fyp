//
//  SelectTechniqueView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct SelectTechniqueView: View {
    @EnvironmentObject private var store: Store
    @State private var techniques: [Technique] = .init()
    
    func getColor(index: Int) -> Color {
        switch index {
        case 1: return .red
        case 2: return .green
        case 3: return .cyan
        case 4: return .yellow
        default: return .brown
        }
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background layer
                Color.theme.background
                    .ignoresSafeArea()
                
                // content layer
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
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    LazyVGrid(columns: columns) {
                        ForEach(Array(techniques.enumerated()), id: \.1) { index, technique in
                            NavigationLink(destination: TechniqueDetailsView(technique: technique)) {
                                TechniqueCardView(technique: technique, color: getColor(index: index))
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .task {
                self.techniques = await Technique.all
            }
        }
    }
}

#Preview {
    SelectTechniqueView()
}
