//
//  GalleryScreen.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import SwiftUI

struct GalleryScreen: View {
    
    static let imageUrlHardcoded = "https://www.artic.edu/iiif/2/2d484387-2509-5e8e-2c43-22f9981972eb/full/843,/0/default.jpg"
    
    var data: [ArtworkThumbnailRenderable] = [
        ArtworkThumbnailRenderable(
            imageUrl: URL(string: GalleryScreen.imageUrlHardcoded)
        ),
        ArtworkThumbnailRenderable(
            imageUrl: URL(string: GalleryScreen.imageUrlHardcoded)
        ),
        ArtworkThumbnailRenderable(
            imageUrl: URL(string: GalleryScreen.imageUrlHardcoded)
        ),
        ArtworkThumbnailRenderable(
            imageUrl: URL(string: GalleryScreen.imageUrlHardcoded)
        ),
        ArtworkThumbnailRenderable(
            imageUrl: URL(string: GalleryScreen.imageUrlHardcoded)
        ),
        ArtworkThumbnailRenderable(
            imageUrl: URL(string: GalleryScreen.imageUrlHardcoded)
        ),
        ArtworkThumbnailRenderable(
            imageUrl: URL(string: GalleryScreen.imageUrlHardcoded)
        ),
        ArtworkThumbnailRenderable(
            imageUrl: URL(string: GalleryScreen.imageUrlHardcoded)
        ),
        ArtworkThumbnailRenderable(
            imageUrl: URL(string: GalleryScreen.imageUrlHardcoded)
        ),
    ]
    
    @ViewBuilder
    var gridContent: some View {
        ForEach(
            data,
            id: \.id,
            content: { item in
                AsyncImage(
                    url: item.imageUrl,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(
                                maxWidth: 300, 
                                maxHeight: 300
                            )
                    },
                    placeholder: {
                        ProgressView()
                            .padding()
                    }
                )
                
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
        .navigationTitle("Artwork Gallery")
    }
}

#Preview {
    NavigationStack {
        GalleryScreen()
    }
    
}
