//
//  NetworkServiceTests.swift
//  MyGalleryTests
//
//  Created by Akirah Dev on 19/10/23.
//  
//

import XCTest
@testable import MyGallery

struct MockNetworkServiceSpec: NetworkServiceSpec {
    var url: String { "" }
    
    var method: MyGallery.HTTPMethod { .get }
    
    typealias Response = ImageIIIF
}

final class NetworkServiceSpecTests: XCTestCase {

    func test_mapping_withData_shouldReturnResponse() {
        
        let rawJsonString: String = """
            {
                "id": 27992,
                "title": "Titless",
                "image_id": "2d484387-2509-5e8e-2c43-22f9981972eb"
            }
        """
        
        let spec = MockNetworkServiceSpec()
        let imageIIIF = try? spec.map(Data(rawJsonString.utf8))
        
        let actualId = imageIIIF?.id
        let expectedId = 27992
        XCTAssertEqual(actualId, expectedId)
        
        let actualTitle = imageIIIF?.title
        let expectedTitle = "Titless"
        XCTAssertEqual(actualTitle, expectedTitle)
        
        let actualImageId = imageIIIF?.imageId
        let expectedImageId = "2d484387-2509-5e8e-2c43-22f9981972eb"
        XCTAssertEqual(actualImageId, expectedImageId)
    }
    
    func test_mappingError_withData_shouldReturnResponse() {
        
        let rawJsonString: String = """
            {
                "status": 403,
                "error": "title error",
                "detail": "detail error"
            }
        """
        
        let spec = MockNetworkServiceSpec()
        let apiError = try? spec.mapApiError(Data(rawJsonString.utf8))
        
        let actualStatus = apiError?.status
        let expectedStatus = 403
        XCTAssertEqual(actualStatus, expectedStatus)
        
        let actualError = apiError?.error
        let expectedError = "title error"
        XCTAssertEqual(actualError, expectedError)
        
        let actualImageDetail = apiError?.detail
        let expectedImageDetail = "detail error"
        XCTAssertEqual(actualImageDetail, expectedImageDetail)
    }
    
    func test_mappingDictionary_withData_shouldReturnResponse() {
        
        let rawJsonString: String = """
            {
                "status": 403,
                "error": "title error",
                "detail": "detail error"
            }
        """
        
        let spec = MockNetworkServiceSpec()
        let dictionary = try? spec.mapToDictionary(Data(rawJsonString.utf8))
        
        let actualStatus = dictionary?["status"] as? Int
        let expectedStatus = 403
        XCTAssertEqual(actualStatus, expectedStatus)
        
        let actualError = dictionary?["error"] as? String
        let expectedError = "title error"
        XCTAssertEqual(actualError, expectedError)
        
        let actualImageDetail = dictionary?["detail"] as? String
        let expectedImageDetail = "detail error"
        XCTAssertEqual(actualImageDetail, expectedImageDetail)
    }
    
    func test_baseUrl_shouldReturnAsExpected() {
        let spec = MockNetworkServiceSpec()
        let actualBaseUrl = spec.baseUrl
        let expectedBaseUrl = "https://api.artic.edu"
        XCTAssertEqual(actualBaseUrl, expectedBaseUrl)
    }
    
    func test_headers_withDefault_shouldReturnEmpty() {
        let spec = MockNetworkServiceSpec()
        let actualHeaderCount = spec.headers.count
        let expectedHeaderCount = 0
        XCTAssertEqual(actualHeaderCount, expectedHeaderCount)
    }
    
    func test_queryItem_withDefault_shouldReturnEmpty() {
        let spec = MockNetworkServiceSpec()
        let actualQueryCount = spec.queryItems.count
        let expectedQueryCount = 0
        XCTAssertEqual(actualQueryCount, expectedQueryCount)
    }
    
    func test_body_withDefault_shouldReturnNil() {
        let spec = MockNetworkServiceSpec()
        XCTAssertNil(spec.body)
    }

}
