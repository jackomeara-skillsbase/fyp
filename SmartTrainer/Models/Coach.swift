//
//  Coach.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import Foundation

struct Coach: Identifiable, Codable, Hashable {
    let id: Int64
    let name: String
    let email: String
    let image: String
}
