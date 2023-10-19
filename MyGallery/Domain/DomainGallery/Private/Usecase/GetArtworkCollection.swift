//
//  GetArtworkCollection.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

struct GetArtworkCollection: NetworkServiceSpec {
    
    typealias Response = APIResponsePagination<Artwork>
    
    private let query: String?
    private let page: Int
    private let limit: Int
    
    init(query: String? = nil, page: Int, limit: Int) {
        self.query = query
        self.page = page
        self.limit = limit
    }
    
    var url: String {
        if let query {
            return String(
                format: "%@/%@",
                baseUrl,
                "api/v1/artworks/search"
            )
        } else {
            return String(
                format: "%@/%@",
                baseUrl,
                "api/v1/artworks"
            )
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String : String] {
        if let query {
            return [
                "q": query,
                "limit": String(format: "%d", limit),
                "page": String(format: "%d", page),
            ]
        } else {
            return [
                "limit": String(format: "%d", limit),
                "page": String(format: "%d", page),
            ]
        }
        
    }
}
