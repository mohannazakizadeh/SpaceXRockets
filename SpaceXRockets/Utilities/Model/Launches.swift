//
//  Launches.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation

// MARK: - Launches
struct Launches: Decodable {
    let launches: [Launch]
    let totalDocs, limit, totalPages, page: Int
    let hasPrevPage, hasNextPage: Bool
    let prevPage: Int?
    let nextPage: Int?

    enum CodingKeys: String, CodingKey {
        case launches = "docs"
        case totalDocs, limit, totalPages, page, hasPrevPage, hasNextPage, prevPage, nextPage
    }
}

// MARK: - Launch
struct Launch: Decodable {
    let links: Links
    let rocket: String
    let success: Bool?
    let details: String?
    let flightNumber: Int
    let name: String
    let dateLocal: String

    enum CodingKeys: String, CodingKey {
        case links, rocket, success, details
        case flightNumber = "flight_number"
        case name
        case dateLocal = "date_local"
    }
    func getState() -> LaunchState? {
        switch success {
        case true:
            return .success
        case false:
            return .failure
        default:
            return nil
        }
    }

    func getFormattedDate() -> String? {
        let dateFormatter = ISO8601DateFormatter()
        let stringDate = dateFormatter.date(from: dateLocal)?.formatted(date: .abbreviated, time: .omitted)
        return stringDate
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
