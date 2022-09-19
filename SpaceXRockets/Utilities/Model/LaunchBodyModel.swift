//
//  LaunchBodyModel.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation

// MARK: - Body
struct Body: Encodable {
    let query: Query
    let options: Options
}

// MARK: - Options
struct Options: Encodable {
    let limit, page: Int
    let sort: Sort
}

// MARK: - Sort
struct Sort: Encodable {
    let flightNumber: String

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
    }
}

// MARK: - Query
struct Query: Encodable {
    let upcoming: Bool
}
