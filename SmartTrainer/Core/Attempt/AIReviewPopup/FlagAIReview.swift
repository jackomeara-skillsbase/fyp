//
//  FlagAIReview.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 01/04/2024.
//

import SwiftUI

struct FlagAIReview: View {
    @EnvironmentObject private var store: Store
    var review: AIReview
    var isFlagged: Bool
    @Binding var showFlagReview: Bool
    @State var flagReviewText: String = ""
    
    var body: some View {
        VStack {
            if isFlagged {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
                    .imageScale(.large)
                Text("Review flagged:")
                Text(review.flagged_description != "" ? "\"\(review.flagged_description)\"" : "No description added")
            } else {
                Button {
                    showFlagReview.toggle()
                } label: {
                    VStack {
//                        Image(systemName: "exclamationmark.triangle")
//                            .foregroundStyle(.red)
//                            .imageScale(.large)
                        Text("Mark as inaccurate")
                    }
                }
                .sheet(isPresented: $showFlagReview) {
                    // show flag review component
                    VStack {
                        Text("Flag AI Review as Inaccurate")
                        TextField("Add Description", text: $flagReviewText)
                        Button("Submit") {
                            // send flag
                            Task {
                                do {
                                    try await AIReviewDataService.flagAIReview(review: review, description: flagReviewText)
                                } catch {}
                            }
                        }
                    }
                    .padding()
                }
                .presentationDetents([.fraction(0.7)])
            }
            
        }
    }
}

//#Preview {
//    FlagAIReview(isFlagged: false, showFlagReview: .constant(false))
//}
