//
//  ArtworkInteractor.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public protocol ArtworkInteractor {
    
    func fetchArtworks(page: Int, limit: Int) async throws -> APIResponsePagination<Artwork>?
    
    func fetchImageUrl(artworkId: String) async throws -> URL?
    
    func searchArtworks(query: String) async throws -> APIResponsePagination<Artwork>?
}
