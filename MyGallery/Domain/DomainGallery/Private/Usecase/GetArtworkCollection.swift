//
//  GetArtworkCollection.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

struct GetArtworkCollection: NetworkServiceSpec {
    
    typealias Response = APIResponsePagination<Artwork>
    
    private let page: Int
    private let limit: Int
    
    init(page: Int, limit: Int) {
        self.page = page
        self.limit = limit
    }
    
    var url: String {
        String(
            format: "%@/%@",
            baseUrl,
            "/api/v1/artworks"
        )
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String : String] {
        [
            "limit": String(format: "%d", limit),
            "page": String(format: "%d", page),
        ]
    }
}
