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
    
    func fetchArtworks(query: String?, page: Int, limit: Int) async throws -> APIResponsePagination<Artwork>? {
        return try await service.request(GetArtworkCollection(query: query, page: page, limit: limit))
    }
    
    /// Fetching image url from given artworkId. The flow process is supposed to be
    /// - Retrieve one or more artworks with image_id fields through API Request
    /// - Find the base IIIF Image API endpoint in the `config.iiif_url`
    /// - Append the `image_id` of the artwork as a segment to this URL
    /// - Append `/full/843,/0/default.jpg` to the URL
    ///
    /// - Parameters
    ///     - artworkId: given id from Artwork item in collection.
    /// - Returns: Formatted URL to fetch image over internet
    func fetchImageUrl(artworkId: Int) async throws -> URL? {
        let usecase = GetImageIIIF(artworkId: artworkId)
        let responseObj = try await service.request(usecase)
        let imageIIIF: ImageIIIF? = responseObj.data
        guard let imageId = imageIIIF?.imageId else {
            return nil
        }
        let urlString: String = String(
            format: "%@/%@/%@",
            responseObj.config?.iiifUrl ?? "https://www.artic.edu",
            imageId,
            "full/843,/0/default.jpg"
        )
        return URL(string: urlString)
    }
    
}
