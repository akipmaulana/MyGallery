//
//  GalleryInteractorBuilderTests.swift
//  MyGalleryTests
//
//  Created by Akirah Dev on 19/10/23.
//  
//

import XCTest
@testable import MyGallery

extension DefaultArtworkInteractor: CustomStringConvertible, Equatable {
    
    public static func == (lhs: MyGallery.DefaultArtworkInteractor, rhs: MyGallery.DefaultArtworkInteractor) -> Bool {
        lhs.description == rhs.description
    }
    
    public var description: String {
        "DefaultArtworkInteractor"
    }
}

final class GalleryInteractorBuilderTests: XCTestCase {

    func test_artwork_withoutAssigned_shouldReturnDefaultInteractor() {
        
        let sut = GalleryInteractorBuilder()
        
        let artworkActual = sut.artwork as? DefaultArtworkInteractor
        let artworkExpected = DefaultArtworkInteractor(
            service: NetworkServiceRestful()
        )
        
        XCTAssertEqual(artworkActual, artworkExpected)
    }
    
    func test_artwork_withAssigned_shouldReturnDefaultInteractor() {
        
        var sut = GalleryInteractorBuilder()
        sut.artwork = DefaultArtworkInteractor(
            service: NetworkServiceRestful()
        )
        let artworkActual = sut.artwork as? DefaultArtworkInteractor
        let artworkExpected = DefaultArtworkInteractor(
            service: NetworkServiceRestful()
        )
        
        XCTAssertEqual(artworkActual, artworkExpected)
    }

}
