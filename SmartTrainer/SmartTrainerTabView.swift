//
//  SmartTrainerTabView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct SmartTrainerTabView: View {
    @EnvironmentObject private var vm: HomeViewModel
    var body: some View {
        if vm.role == "player" {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                PlayerRecordView()
                    .tabItem {
                        Image(systemName: "plus")
                    }
                PlayerProfileView()
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
        }
        else if vm.role == "coach"{
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                CoachPlayersView()
                    .tabItem {
                        Image(systemName: "person.3")
                    }
                CoachProfileView()
                    .tabItem {
                        Image(systemName: "person")
                    }
                DrawFeedbackView()
                    .tabItem {
                        Image(systemName: "pencil")
                    }
                VideoPlayerView()
                    .tabItem {
                        Image(systemName: "video")
                    }
            }
        }
    }
}

#Preview {
    SmartTrainerTabView()
        .environmentObject(HomeViewModel())
}
