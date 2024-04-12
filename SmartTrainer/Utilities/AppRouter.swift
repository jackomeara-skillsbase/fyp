//
//  AppRouter.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 04/04/2024.
//

import Foundation
import SwiftUI

final public class AppRouter: ObservableObject {
    @Published var navPath = NavigationPath()
    
    func push(to destination: any Hashable) {
        navPath.append(destination)
    }
    
    func pop() {
        navPath.removeLast()
    }
    
    func popToRoot() {
        navPath.removeLast(navPath.count)
    }
}
