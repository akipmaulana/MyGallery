//
//  GetImageIIIF.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

struct GetImageIIIF: NetworkServiceSpec {
    
    typealias Response = APIResponseObject<ImageIIIF>
    
    private let artworkId: Int
    
    init(artworkId: Int) {
        self.artworkId = artworkId
    }
    
    var url: String {
        String(
            format: "%@/%@/%d",
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
