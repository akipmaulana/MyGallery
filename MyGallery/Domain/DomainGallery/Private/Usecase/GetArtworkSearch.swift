//
//  GetArtworkSearch.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

struct GetArtworkSearch: NetworkServiceSpec {
    
    typealias Response = APIResponsePagination<Artwork>
    
    private let query: String
    
    init(query: String) {
        self.query = query
    }
    
    var url: String {
        String(
            format: "%@/%@",
            baseUrl,
            "/api/v1/artworks/search"
        )
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String : String] {
        [
            "query": query
        ]
    }
}
