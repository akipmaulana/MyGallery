//
//  ErrorNetwork+CustomStringConvertible.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

extension ErrorNetwork: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("[Error Network]Invalid response", comment: "")
        case .invalidRequest:
            return NSLocalizedString("[Error Network] No Data", comment: "")
        case .serializationError:
            return NSLocalizedString("[Error Network] Serialization Error", comment: "")
        case .forbidden(let model), .internalServer(let model), .notFound(let model):
            return NSLocalizedString(model.error ?? "[Error Network] Bad Request", comment: "")
        }
    }
}
