//
//  GalleryInteractorBuilder.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public struct GalleryInteractorBuilder {
    
    private var _artwork: ArtworkInteractor?
    public var artwork: ArtworkInteractor {
        set {
            self._artwork = newValue
        }
        get {
            guard let _artwork else {
                return DefaultArtworkInteractor(
                    service: NetworkServiceRestful()
                )
            }
            return _artwork
        }
    }
}
