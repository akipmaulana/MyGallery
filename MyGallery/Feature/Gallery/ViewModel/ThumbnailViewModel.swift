//
//  ThumbnailViewModel.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

final class ThumbnailViewModel: ObservableObject {
    
    @Published var imageUrl: URL?
    
    func fetchImageArtwork(id: Int) async {
        do {
            let _imageUrl = try await GalleryInteractorBuilder()
                .artwork
                .fetchImageUrl(
                    artworkId: id
                )
            DispatchQueue.main.async { [weak self] in
                self?.imageUrl = _imageUrl
            }
        } catch(let error) {
            debugPrint("Error When Refresh Gallery \(error.localizedDescription)")
        }
    }
}
