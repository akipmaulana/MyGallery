//
//  RemoteEnum.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public typealias StubResult = Result<Data, Error>

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum ErrorNetwork: Error {
    case invalidRequest
    case invalidResponse
    case serializationError
    case forbidden(model: APIResponseError)
    case notFound(model: APIResponseError)
    case internalServer(model: APIResponseError)
}
