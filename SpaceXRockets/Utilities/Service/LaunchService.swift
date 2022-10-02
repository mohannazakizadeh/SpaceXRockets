//
//  LaunchService.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation

final class LaunchService: LaunchServiceProtocol {

    private let requestManager: RequestManagerProtocol

    public static let shared: LaunchServiceProtocol = LaunchService(requestManager: RequestManager.shared)
    private let limit = 20

    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }

    func fetchLaunches(page: Int, completionHandler: @escaping LaunchesCompletionHandler) {
        let body = bodyBuilder(page: page)

        self.requestManager
            .performRequestWith(httpMethod: .post, body: body) { (result: Result<Launches, RequestError>) in
            // Taking Data to main thread so we can update UI.
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }

    private func bodyBuilder(page: Int) -> Data? {
        let sort = Sort(flightNumber: "desc")
        let options = Options(limit: limit, page: page, sort: sort)
        let query = Query(upcoming: false)
        let body = Body(query: query, options: options)
        let data = try? JSONEncoder().encode(body)
        return data
    }
}
