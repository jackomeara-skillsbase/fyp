//
//  User.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 07/02/2024.
//

import Foundation

enum userRole: String, Codable {
    case player, coach, manager
}

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let role: userRole
    let image_url: String
}
