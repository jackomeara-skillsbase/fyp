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
    @StateObject private var globalVM: GlobalViewModel = GlobalViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            if vm.authenticated {
                SmartTrainerTabView()
                    .environmentObject(vm)
            } else {
                LogInView()
                    .environmentObject(vm)
            }
        }
    }
}
