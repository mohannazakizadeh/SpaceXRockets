//
//  LaunchesInteractor.swift
//  Launches
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation

final class LaunchesInteractor: InteractorInterface {

    weak var presenter: LaunchesPresenterInteractorInterface!
}

extension LaunchesInteractor: LaunchesInteractorInterface {
    func getLaunches(page: Int, completionHandler: @escaping LaunchesCompletionHandler) {
        LaunchService.shared.fetchLaunches(page: page) { result in
            completionHandler(result)
        }
    }

}
