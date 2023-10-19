//
//  ThumbnailViewModel.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

final class ThumbnailViewModel: ObservableObject {
    
    @Published var imageUrl: URL?
    
    let interactor: ArtworkInteractor
    
    init(interactor: ArtworkInteractor = GalleryInteractorBuilder().artwork) {
        self.interactor = interactor
    }
    
    func fetchImageArtwork(id: Int) async {
        do {
            imageUrl = try await interactor.fetchImageUrl(artworkId: id)
            print("Image URL \(imageUrl)")
        } catch(let error) {
            debugPrint("Error When Refresh Gallery \(error.localizedDescription)")
        }
    }
}
