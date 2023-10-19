//
//  Artwork.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public struct Artwork: Decodable {
    let _score: Double?
    let thumbnail: ArtworkThumbnail?
    let apiModel: String?
    let isBoosted: Bool?
    let apiLink: String?
    let id: Int?
    let title: String?
    let timestamp: String?
}

public struct ArtworkThumbnail: Decodable {
    let altText: String?
    let width: Int?
    let lqip: String?
    let height: Int?
}
