//
//  ThumbnailView.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import SwiftUI

struct ThumbnailView: View {
    
    private let artworkId: Int?
    
    init(artworkId: Int?) {
        self.artworkId = artworkId
    }
    
    @ObservedObject private var viewModel: ThumbnailViewModel = ThumbnailViewModel()
    
    var body: some View {
        if let artworkId {
            AsyncImage(
                url: viewModel.imageUrl,
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
            .task {
                await viewModel.fetchImageArtwork(id: artworkId)
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    ThumbnailView(artworkId: 27992)
}
