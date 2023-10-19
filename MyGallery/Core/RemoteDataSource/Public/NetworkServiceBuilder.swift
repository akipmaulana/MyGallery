//
//  NetworkServiceBuilder.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public struct NetworkServiceBuilder {
    
    private var _rest: NetworkService?
    public var rest: NetworkService? {
        set {
            self._rest = newValue
        }
        get {
            guard let _rest else {
                return NetworkServiceRestful()
            }
            return _rest
        }
    }
}
