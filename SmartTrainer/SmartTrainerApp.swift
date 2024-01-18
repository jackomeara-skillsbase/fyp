//
//  SmartTrainerApp.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

@main
struct SmartTrainerApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            SmartTrainerTabView()
                .environmentObject(vm)
        }
    }
}
