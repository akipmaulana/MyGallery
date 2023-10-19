//
//  ArtworkInteractor.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public protocol ArtworkInteractor {
    
    func fetchArtworks(query: String?, page: Int, limit: Int) async throws -> APIResponsePagination<Artwork>?
    
    func fetchImageUrl(artworkId: Int) async throws -> URL?
}
