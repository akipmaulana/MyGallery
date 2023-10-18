//
//  APIResponseError.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public struct APIResponseError: Decodable {
    
    public let status: Int?
    public let error: String?
    public let detail: String?
}
