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
    
    @State var imageUrl: URL?
    
    var body: some View {
        if let artworkId {
            AsyncImage(
                url: imageUrl,
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
                if imageUrl == nil {
                    await fetchImageArtwork(id: artworkId)
                }
            }
        } else {
            EmptyView()
        }
    }
    
    func fetchImageArtwork(id: Int) async {
        do {
            let _imageUrl = try await GalleryInteractorBuilder()
                .artwork
                .fetchImageUrl(
                    artworkId: id
                )
            DispatchQueue.main.async {
                print("fetchImageArtwork")
                imageUrl = _imageUrl
            }
        } catch(let error) {
            debugPrint("Error When Refresh Gallery \(error.localizedDescription)")
        }
    }
}

#Preview {
    ThumbnailView(artworkId: 27992)
}
