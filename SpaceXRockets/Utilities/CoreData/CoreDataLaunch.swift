//
//  CoreDataLaunch.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/29/22.
//

import Foundation

struct CoreDataLaunch {
    let name: String
    let success: Bool
    let details: String
    let flightNumber: Int
    let date: String
    let launchIconLink: String
    let launchImageLink: String
    let wikipedia: String
    let article: String
    let webcast: String

    func getState() -> LaunchState? {
        switch success {
        case true:
            return .success
        case false:
            return .failure
        }
    }
}
