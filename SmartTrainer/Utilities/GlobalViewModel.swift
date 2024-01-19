//
//  GlobalViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 19/01/2024.
//

import Foundation

class GlobalViewModel: ObservableObject {
    static let shared = GlobalViewModel()
    
    var role: String = "player"
    var email: String = "the_special_one@gmail.com"
    var name: String = "Jose Mourinho"
    var id: Int = 1
    @Published var authenticated: Bool = false
    
    private init() {}
}
