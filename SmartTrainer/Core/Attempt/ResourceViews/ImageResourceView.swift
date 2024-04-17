//
//  ImageResourceView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 26/03/2024.
//

import SwiftUI

struct ImageResourceView: View {
    @EnvironmentObject private var store: Store
    
    var imageURL: String
    
    var body: some View {
        ZStack {
            
            // load image
            AsyncCachedImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .containerRelativeFrame([.horizontal, .vertical])
            } placeholder: {
                if imageURL != "" {
                    VStack {
                        ProgressView()
                    }
                    .containerRelativeFrame([.horizontal, .vertical])
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color.blue.opacity(0.6))
                            .containerRelativeFrame([.horizontal, .vertical])
                        Text("Image: \(imageURL)")
                            .font(.title)
                            .bold()
                    }
                }
            }
            
            // overlay items
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    
                    Spacer()
                    
                    // tool buttons on right
                    VStack(spacing: 30) {
                        // delete button if coach
                        
                        
                        // comments popup button
                        PopupButton(imageURL: imageURL, symbol: "message.fill")
                            .environmentObject(store)
                    }
                    .padding()
                }
            }
            .padding(.bottom, 80)
        }
    }
                            
    struct PopupButton: View {
        @EnvironmentObject private var store: Store
        var imageURL: String
        var symbol: String
        
        var body: some View {
            Button {
                store.commentMedia = imageURL
                store.showComments = true
            } label: {
                Image(systemName: symbol)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.white)
                    .shadow(color: .black, radius: 3)
            }
        }
        
    }
}

#Preview {
    ImageResourceView(imageURL: "someimage")
}
