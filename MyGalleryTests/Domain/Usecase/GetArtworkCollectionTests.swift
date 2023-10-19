//
//  GetArtworkCollectionTests.swift
//  MyGalleryTests
//
//  Created by Akirah Dev on 19/10/23.
//  
//

import XCTest
@testable import MyGallery

final class GetArtworkCollectionTests: XCTestCase {
    
    func test_httpUrl_withoutQuery_shouldReturnEndpointFetchOnly() {
        let usecase = GetArtworkCollection(page: 1, limit: 15)
        let containsEndpointSearch: Bool = usecase.url.contains("api/v1/artworks")
        XCTAssertTrue(containsEndpointSearch)
    }
    
    func test_httpUrl_withoutQuery_shouldReturnExpectedParam() {
        let usecase = GetArtworkCollection(page: 1, limit: 15)
        let actualQuery = usecase.queryItems["q"]
        let expectedQuery: String? = nil
        XCTAssertEqual(actualQuery, expectedQuery)
        let actualPage = usecase.queryItems["page"]
        let expectedPage = "1"
        XCTAssertEqual(actualQuery, expectedQuery)
        let actualLimit = usecase.queryItems["limit"]
        let expectedLimit = "15"
        XCTAssertEqual(actualQuery, expectedQuery)
    }
    
    func test_httpUrl_withoutQuery_shouldReturnMethodGet() {
        let usecase = GetArtworkCollection(page: 1, limit: 15)
        let actualMethod = usecase.method
        let expectedMethod: HTTPMethod = .get
        XCTAssertEqual(actualMethod, expectedMethod)
    }

    func test_httpUrl_withQuery_shouldReturnEndpointSearch() {
        let usecase = GetArtworkCollection(query: "japan", page: 1, limit: 15)
        let containsEndpointSearch: Bool = usecase.url.contains("api/v1/artworks/search")
        XCTAssertTrue(containsEndpointSearch)
    }
    
    func test_httpUrl_withQuery_shouldReturnExpectedParam() {
        let usecase = GetArtworkCollection(query: "japan", page: 1, limit: 15)
        let actualQuery = usecase.queryItems["q"]
        let expectedQuery = "japan"
        XCTAssertEqual(actualQuery, expectedQuery)
        let actualPage = usecase.queryItems["page"]
        let expectedPage = "1"
        XCTAssertEqual(actualQuery, expectedQuery)
        let actualLimit = usecase.queryItems["limit"]
        let expectedLimit = "15"
        XCTAssertEqual(actualQuery, expectedQuery)
    }
    
    func test_httpUrl_withQuery_shouldReturnMethodGet() {
        let usecase = GetArtworkCollection(query: "japan", page: 1, limit: 15)
        let actualMethod = usecase.method
        let expectedMethod: HTTPMethod = .get
        XCTAssertEqual(actualMethod, expectedMethod)
    }

}
