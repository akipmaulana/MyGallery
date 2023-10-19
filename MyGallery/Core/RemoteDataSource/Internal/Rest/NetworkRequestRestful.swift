//
//  NetworkServiceRestful.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation
import UIKit

internal struct NetworkServiceRestful: NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
    @available(iOS 13.0.0, *)
    func request<U: NetworkServiceSpec>(_ spec: U) async throws -> U.Response {
        
        guard let urlRequest = makeURLRequest(spec) else {
            throw ErrorNetwork.invalidRequest
        }
        
        debugPrint("[REQUEST] Network Logger Begin\n\n")
        urlRequest.debug()
        debugPrint("[REQUEST] Network Logger End\n\n")
        
        var (data, response): (Data, URLResponse)
            
        do {
            (data, response) = try await session.data(for: urlRequest)
            
            debugPrint("[RESPONSE] Network Logger Begin\n\n")
            
        } catch(let error) {
            debugPrint("[RESPONSE] Network Logger Begin\n\n")
            debugPrint("Response Error \(error.localizedDescription)")
            debugPrint("[RESPONSE] Network Logger End\n\n")
            
            throw error
        }
        
        guard let response = response as? HTTPURLResponse else {
            debugPrint("Response Error \(ErrorNetwork.invalidResponse)")
            debugPrint("[RESPONSE] Network Logger End\n\n")
            throw ErrorNetwork.invalidResponse
        }
        
        do {
            debugPrint("Status Code \(response.statusCode)")
            debugPrint("Response data string: \(String(data: data, encoding: .utf8) ?? "-")")
            debugPrint("[RESPONSE] Network Logger End\n\n")
            
            switch response.statusCode {
            case 200..<300:
                let response = try spec.map(data)
                return response
            case 403:
                let model = try spec.mapApiError(data)
                throw ErrorNetwork.forbidden(model: model)
            case 404:
                let model = try spec.mapApiError(data)
                throw ErrorNetwork.notFound(model: model)
            case 500:
                let model = try spec.mapApiError(data)
                throw ErrorNetwork.internalServer(model: model)
            default:
                debugPrint("[RESPONSE] Network Logger End\n\n")
                throw ErrorNetwork.serializationError
            }
            
        } catch(let error) {
            debugPrint("[RESPONSE] Serialization Error \(error)")
            debugPrint("[RESPONSE] Network Logger End\n\n")
            throw error
        }
    }
    
    private func makeURLRequest<U: NetworkServiceSpec>(_ spec: U) -> URLRequest? {
        
        guard var urlComponent = URLComponents(string: spec.url) else {
            return nil
        }
        
        var queryItems: [URLQueryItem] = []
        
        spec.queryItems.forEach {
            let queryitem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(queryitem)
            queryItems.append(queryitem)
        }
        
        urlComponent.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = urlComponent.url else {
            return nil
        }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = spec.method.rawValue
        urlRequest.allHTTPHeaderFields = makeHttpHeader(spec)
        urlRequest.httpBody = makeHttpBody(spec.body)
        return urlRequest
    }
    
    private func makeHttpBody(_ encodable: Encodable?) -> Data? {
        let decoder = JSONEncoder()
        guard let encodable = encodable else { return nil }
        do {
            return try decoder.encode(encodable)
        } catch(let error) {
            debugPrint("[REQUEST] Error make http body: \(error)")
            return nil
        }
    }
    
    private func makeHttpHeader<U: NetworkServiceSpec>(_ spec: U) -> [String: String] {
        let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        
        var defaultHttpHeader: [String: String] = [
            "Platform": "ios",
            "Accept": "application/json",
            "User-Agent": UIDevice.current.name,
            "X-App-Version": "ios-V\(shortVersion ?? "")",
        ]
        defaultHttpHeader.merge(spec.headers, uniquingKeysWith: {(current, _) in current})
        
        if !spec.queryItems.isEmpty {
            defaultHttpHeader["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
        }
        
        if spec.body != nil {
            defaultHttpHeader["Content-Type"] = "application/json"
        }
        
        return defaultHttpHeader
    }
}
