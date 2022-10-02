//
//  LaunchServiceProtocol.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation

typealias LaunchesCompletionHandler = (Result<Launches, RequestError>) -> Void

protocol LaunchServiceProtocol {
    func fetchLaunches(page: Int, completionHandler: @escaping LaunchesCompletionHandler)
}
