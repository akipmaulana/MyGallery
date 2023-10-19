//
//  APIResponseObject.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

public struct APIResponseObject<D: Decodable>: Decodable {
    let data: D?
    let info: APIResponsePaginationInfo?
    let config: APIResponsePaginationConfig?
}

public struct APIResponsePagination<D: Decodable>: Decodable {
    let pagination: APIResponsePaginationProp?
    let data: [D]?
    let info: APIResponsePaginationInfo?
    let config: APIResponsePaginationConfig?
}

public struct APIResponsePaginationProp: Decodable {
    let total: Int?
    let limit: Int?
    let offset: Int?
    let totalPages: Int?
    let currentPage: Int?
}

public struct APIResponsePaginationInfo: Decodable {
    let licenseText: String?
    let licenseLinks: [String]?
    let version: String?
}

public struct APIResponsePaginationConfig: Decodable {
    let iiifUrl: String?
    let websiteUrl: String?
}
