//
//  GetImageIIIF.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

struct GetImageIIIF: NetworkServiceSpec {
    
    typealias Response = ImageIIIF
    
    private let artworkId: String
    
    init(artworkId: String) {
        self.artworkId = artworkId
    }
    
    var url: String {
        String(
            format: "%@/%@/%@",
            baseUrl,
            "api/v1/artworks",
            artworkId
        )
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String : String] {
        [
            "fields": "id,title,image_id"
        ]
    }
}
