//
//  DefaultArtworkInteractor.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

struct DefaultArtworkInteractor: ArtworkInteractor {
    
    private let service: any NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func fetchArtworks(page: Int, limit: Int) async throws -> APIResponsePagination<Artwork>? {
        return try await service.request(GetArtworkCollection(page: page, limit: limit))
    }
    
    func fetchImageUrl(artworkId: Int) async throws -> URL? {
        let usecase = GetImageIIIF(artworkId: artworkId)
        let imageIIIF = try await service.request(usecase).data
        guard let imageId = imageIIIF?.imageId else {
            return nil
        }
        return URL(string: String(
            format: "%@/%@/%@/%@",
            "https://www.artic.edu",
            "iiif/2",
            imageId,
            "full/200,/0/default.jpg"
        ))
    }
    
    func searchArtworks(query: String) async throws -> APIResponsePagination<Artwork>? {
        return try await service.request(GetArtworkSearch(query: query))
    }
    
    
}
