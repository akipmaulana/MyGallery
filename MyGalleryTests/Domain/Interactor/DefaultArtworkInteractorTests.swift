//
//  DefaultArtworkInteractorTests.swift
//  MyGalleryTests
//
//  Created by Akirah Dev on 19/10/23.
//  
//

import XCTest
@testable import MyGallery

final class DefaultArtworkInteractorTests: XCTestCase {
    
    var artworkPaginationData: Data?

    override func setUpWithError() throws {
        
        guard
            let artworkPaginationUrl = Bundle.main.url(forResource: "artwork_pagination", withExtension: "json")
        else {
            return
        }
        
        artworkPaginationData = try Data(contentsOf: artworkPaginationUrl)
    }

    override func tearDownWithError() throws {
        artworkPaginationData = nil
    }

    func test_fetchArtworks_shouldReturnPagination() async {
        
        let sut = DefaultArtworkInteractor(
            service: NetworkServiceMock(
                result: .success(
                    artworkPaginationData
                )
            )
        )
        
        let pagination = try? await sut.fetchArtworks(query: "test", page: 1, limit: 15)
        let actualTotalPages = pagination?.pagination?.totalPages ?? 0
        let expectedTotalPages: Int = 8214
        XCTAssertEqual(actualTotalPages, expectedTotalPages)
    }
    
    func test_fetchImageUrl_withImageId_shouldReturnExpectedUrl() async {
        
        let rawJsonString: String = """
        {
            "data": {
                "image_id": "2d484387-2509-5e8e-2c43-22f9981972eb"
            },
            "config": {
                "iiif_url": "https://www.artic.edu/iiif/2",
            }
        }
        """
        
        let sut = DefaultArtworkInteractor(
            service: NetworkServiceMock(
                result: .success(Data(rawJsonString.utf8))
            )
        )
        
        let url = try? await sut.fetchImageUrl(artworkId: 123)
        let actualUrl = url
        let expectedUrl: URL? = URL(string: "https://www.artic.edu/iiif/2/2d484387-2509-5e8e-2c43-22f9981972eb/full/843,/0/default.jpg")
        XCTAssertEqual(actualUrl, expectedUrl)
    }
    
    func test_fetchImageUrl_withoutImageId_shouldReturnNil() async {
        
        let rawJsonString: String = """
        {
            "data": {
            }
        }
        """
        
        let sut = DefaultArtworkInteractor(
            service: NetworkServiceMock(
                result: .success(Data(rawJsonString.utf8))
            )
        )
        
        let url = try? await sut.fetchImageUrl(artworkId: 123)
        let actualUrl = url
        let expectedUrl: URL? = nil
        XCTAssertEqual(actualUrl, expectedUrl)
    }
    
    func test_fetchImageUrl_withoutConfigIiifUrl_shouldReturnExpectedUrl() async {
        
        let rawJsonString: String = """
        {
            "data": {
                "image_id": "2d484387-2509-5e8e-2c43-22f9981972eb"
            },
            "config": {
                "website_url": "http://www.artic.edu"
            }
        }
        """
        
        let sut = DefaultArtworkInteractor(
            service: NetworkServiceMock(
                result: .success(Data(rawJsonString.utf8))
            )
        )
        
        let url = try? await sut.fetchImageUrl(artworkId: 123)
        let actualUrl = url
        let expectedUrl: URL? = URL(string: "https://www.artic.edu/iiif/2/2d484387-2509-5e8e-2c43-22f9981972eb/full/843,/0/default.jpg")
        XCTAssertEqual(actualUrl, expectedUrl)
    }
}
