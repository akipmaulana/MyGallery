//
//  NetworkServiceMock.swift
//  MyGalleryTests
//
//  Created by Akirah Dev on 19/10/23.
//  
//

import Foundation
@testable import MyGallery

struct NetworkServiceMock: NetworkService {
    
    private let result: Result<Data?, Error>
    
    init(result: Result<Data?, Error>) {
        self.result = result
    }
    
    func request<U: NetworkServiceSpec>(_ spec: U) async throws -> U.Response {
        switch result {
        case .success(let data):
            guard let data, let response = try? spec.map(data) else {
                throw ErrorNetwork.serializationError
            }
            return response
        case .failure(let error):
            throw error
        }
    }
}
