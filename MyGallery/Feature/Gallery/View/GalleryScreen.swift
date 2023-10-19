//
//  GalleryScreen.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import SwiftUI

struct GalleryScreen: View {
    
    @StateObject private var viewModel = GalleryViewModel()
    
    @ViewBuilder
    var gridContent: some View {
        ForEach(
            viewModel.artworks,
            id: \.id,
            content: { item in
                ThumbnailView(artworkId: item.imageId)
            }
        )
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(),
                        GridItem(),
                        GridItem(),
                    ],
                    content: {
                        gridContent
                    }
                )
            }
        }
        .task {
            await viewModel.refreshGallery()
        }
        .navigationTitle("Artwork Gallery")
    }
}

#Preview {
    NavigationStack {
        GalleryScreen()
    }
    
}
