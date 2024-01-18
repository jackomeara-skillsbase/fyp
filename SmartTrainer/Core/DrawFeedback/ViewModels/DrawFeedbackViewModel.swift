//
//  DrawFeedbackViewModel.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 14/01/2024.
//

import Foundation
import SwiftUI

class DrawFeedbackViewModel: ObservableObject {
    @Published var selectedColor: Color = Color.theme.accent
}
