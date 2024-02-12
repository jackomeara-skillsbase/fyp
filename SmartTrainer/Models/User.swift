//
//  User.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 07/02/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let isCoach: Bool
    let image_url: String
}
