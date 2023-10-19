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

enum GalleryPaginationState {
    case isLoading
    case idle
    case failure(Error)
}

final class GalleryViewModel: ObservableObject {
    
    @Published var artworks: [GalleryThumbnailRenderable] = []
    @Published var paginationState: GalleryPaginationState = .idle
    
    let interactor: ArtworkInteractor
    
    private var page: Int = 1
    private var totalPages: Int = 0
    private var isMoreDataAvailable: Bool = false
    private var query: String?
    
    init(interactor: ArtworkInteractor = GalleryInteractorBuilder().artwork) {
        self.interactor = interactor
    }
    
    func refreshGallery() async {
        DispatchQueue.main.async { [weak self] in
            self?.paginationState = .isLoading
        }
        do {
            let pagination = try await interactor.fetchArtworks(query: query, page: page, limit: 15)
            let artworksRenderable = pagination?
                .data?
                .compactMap{ GalleryThumbnailRenderable(imageId: $0.id) } ?? []
            DispatchQueue.main.async { [weak self] in
                self?.artworks.append(contentsOf: artworksRenderable)
                self?.totalPages = pagination?.pagination?.totalPages ?? 0
                self?.paginationState = .idle
                self?.isMoreDataAvailable = (self?.page ?? 0) < (self?.totalPages ?? 0)
            }
        } catch(let error) {
            debugPrint("Error When Refresh Gallery \(error.localizedDescription)")
            DispatchQueue.main.async { [weak self] in
                self?.paginationState = .failure(error)
            }
        }
    }
    
    func searchGallery(query: String) async {
        if query.isEmpty {
            self.query = nil
        } else {
            self.query = query
        }
        page = 1
        DispatchQueue.main.async { [weak self] in
            self?.artworks = []
        }
        await refreshGallery()
    }
    
    func loadMoreGallery(current thumbnail: GalleryThumbnailRenderable) async {
        let index: Int = artworks.firstIndex(where: { $0.imageId == thumbnail.imageId }) ?? 0
        let thresholdIndex = artworks.count - 3
        
        guard index >= thresholdIndex else {
            return
        }
        
        guard case .idle = paginationState else {
            return
        }
        
        guard isMoreDataAvailable else {
            return
        }
        
        page += 1
        print("loadMoreGallery \(page)")
        await refreshGallery()
    }
}
