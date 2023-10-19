//
//  GalleryViewModel.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import SwiftUI

struct GalleryThumbnailRenderable: Identifiable {
    let id = UUID()
    let imageId: Int?
}

final class GalleryViewModel: ObservableObject {
    
    @Published var artworks: [GalleryThumbnailRenderable] = []
    
    let interactor: ArtworkInteractor
    
    init(interactor: ArtworkInteractor = GalleryInteractorBuilder().artwork) {
        self.interactor = interactor
    }
    
    func refreshGallery() async {
        do {
            let pagination = try await interactor.fetchArtworks(page: 1, limit: 10)
            self.artworks = pagination?
                .data?
                .compactMap{ GalleryThumbnailRenderable(imageId: $0.id) } ?? []
        } catch(let error) {
            debugPrint("Error When Refresh Gallery \(error.localizedDescription)")
        }
    }
}
