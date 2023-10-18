//
//  NetworkService.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public protocol NetworkService {
    
    @available(iOS 13.0.0, *)
    func request<U: NetworkServiceSpec>(
        _ spec: U
    ) async throws -> U.Response
}

public protocol NetworkServiceSpec {
    
    associatedtype Response
    
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [String: String] { get }
    var body: Encodable? { get }
    var keychainBaseUrl: String { get }
    
    func map(_ data: Data) throws -> Response
    
    func mapToDictionary(_ data: Data) throws -> [String: Any]
}

public extension NetworkServiceSpec where Response: Decodable {
    
    func map(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: data)
    }
    
    func mapToDictionary(_ data: Data) throws -> [String: Any] {
        let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return result ?? [:]
    }
}

public extension NetworkServiceSpec {
    
    var baseUrl: String {
        return "https://api.artic.edu/docs/"
    }
    
    func mapApiError(_ data: Data) throws -> APIResponseError {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(APIResponseError.self, from: data)
    }
}

public extension NetworkServiceSpec {
    
    var headers: [String: String] {
        [:]
    }
    
    var queryItems: [String: String] {
        [:]
    }
    
    var body: Encodable? {
        nil
    }
}


