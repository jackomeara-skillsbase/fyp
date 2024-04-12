//
//  AsyncCachedImage.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 28/03/2024.
//
//  code from stack overflow:
//  https://stackoverflow.com/questions/69214543/how-can-i-add-caching-to-asyncimage
//

import SwiftUI

@MainActor
struct AsyncCachedImage<ImageView: View, PlaceholderView: View>: View {
    var url: URL?
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> PlaceholderView
    
    @State var image: UIImage? = nil
    
    init(
        url: URL?,
        @ViewBuilder content: @escaping (Image) -> ImageView,
        @ViewBuilder placeholder: @escaping () -> PlaceholderView
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        VStack {
            if let image = image {
                content(Image(uiImage: image))
            } else {
                placeholder()
                    .onAppear {
                        Task {
                            image = await CacheManager.shared.cacheImage(url:url)
                        }
                    }
            }
        }
    }
}

//#Preview {
//    AsyncCachedImage()
//}
