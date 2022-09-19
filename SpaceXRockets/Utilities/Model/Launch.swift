//
//  Launch.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation

// MARK: - Launch
struct Launch: Decodable {
    let docs: [Doc]
    let totalDocs, limit, totalPages, page: Int
    let hasPrevPage, hasNextPage: Bool
    let prevPage: Int?
    let nextPage: Int?
}

// MARK: - Doc
struct Doc: Decodable {
    let links: Links
    let rocket: String
    let success: Bool
    let details: String?
    let flightNumber: Int
    let name: String
    let dateLocal: Date
    let upcoming: Bool

    enum CodingKeys: String, CodingKey {
        case links, rocket, success, details
        case flightNumber = "flight_number"
        case name
        case dateLocal = "date_local"
        case upcoming
    }
}

// MARK: - Links
struct Links: Decodable {
    let patch: Patch
    let webcast: String?
    let article: String?
    let wikipedia: String?
}

// MARK: - Patch
struct Patch: Decodable {
    let small, large: String
}
