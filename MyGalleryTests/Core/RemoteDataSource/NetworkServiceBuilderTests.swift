//
//  NetworkServiceBuilderTests.swift
//  MyGalleryTests
//
//  Created by Akirah Dev on 19/10/23.
//  
//

import XCTest
@testable import MyGallery

extension NetworkServiceRestful: CustomStringConvertible, Equatable {
    
    public static func == (lhs: MyGallery.NetworkServiceRestful, rhs: MyGallery.NetworkServiceRestful) -> Bool {
        lhs.description == rhs.description
    }
    
    public var description: String {
        "NetworkServiceRestful"
    }
}

final class NetworkServiceBuilderTests: XCTestCase {

    func test_restService_withoutAssigned_shouldReturnRestfulService() {
        
        let sut = NetworkServiceBuilder()
        
        let serviceActual = sut.rest as? NetworkServiceRestful
        let serviceExpected = NetworkServiceRestful()
        
        XCTAssertEqual(serviceActual, serviceExpected)
    }
    
    func test_restService_withAssigned_shouldReturnRestfulService() {
        
        var sut = NetworkServiceBuilder()
        sut.rest = NetworkServiceRestful()
        let actual = sut.rest as? NetworkServiceRestful
        let expected = NetworkServiceRestful()
        
        XCTAssertEqual(actual, expected)
    }

}
