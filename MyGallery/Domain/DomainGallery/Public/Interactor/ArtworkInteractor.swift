//
//  ArtworkInteractor.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public protocol ArtworkInteractor {
    
    func fetchArtworks() async throws -> APIResponsePagination<Artwork>?
    
    func fetchImageData(artworkId: String) async throws -> Data?
    
    func searchArtworks(query: String) async throws -> APIResponsePagination<Artwork>?
}
