//
//  GetImageIIIFTests.swift
//  MyGalleryTests
//
//  Created by Akirah Dev on 19/10/23.
//  
//

import XCTest
@testable import MyGallery

final class GetImageIIIFTests: XCTestCase {

    func test_httpUrl_withId_shouldReturnEndpointArtworkId() {
        let usecase = GetImageIIIF(artworkId: 123)
        let containsExpectedEndpoint: Bool = usecase.url.contains("api/v1/artworks/\(123)")
        XCTAssertTrue(containsExpectedEndpoint)
    }
    
    func test_httpUrl_withId_shouldReturnExpectedParam() {
        let usecase = GetImageIIIF(artworkId: 123)
        let actualQuery = usecase.queryItems["fields"]
        let expectedQuery: String = "id,title,image_id"
        XCTAssertEqual(actualQuery, expectedQuery)
    }
    
    func test_httpUrl_withId_shouldReturnMethodGet() {
        let usecase = GetImageIIIF(artworkId: 123)
        let actualMethod = usecase.method
        let expectedMethod: HTTPMethod = .get
        XCTAssertEqual(actualMethod, expectedMethod)
    }

}
