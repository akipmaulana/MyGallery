//
//  DefaultArtworkInteractor.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

struct DefaultArtworkInteractor: ArtworkInteractor {
    func fetchArtworks() async throws -> APIResponsePagination<Artwork>? {
        nil
    }
    
    func fetchImageData(artworkId: String) async throws -> Data? {
        nil
    }
    
    func searchArtworks(query: String) async throws -> APIResponsePagination<Artwork>? {
        nil
    }
    
    
}
