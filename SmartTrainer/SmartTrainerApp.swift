//
//  SmartTrainerApp.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

@main
struct SmartTrainerApp: App {
    @StateObject private var store: Store = Store()
    
    var body: some Scene {
        WindowGroup {
            if store.authenticated {
                SmartTrainerTabView()
                    .environmentObject(store)
            } else {
                LogInView()
                    .environmentObject(store)
            }
        }
    }
}
