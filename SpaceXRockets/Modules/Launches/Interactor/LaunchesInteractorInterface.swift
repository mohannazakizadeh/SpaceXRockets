//
//  LaunchesInteractorInterface.swift
//  Launches
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation

protocol LaunchesInteractorInterface: InteractorPresenterInterface {
    func getLaunches(page: Int, completionHandler: @escaping LaunchesCompletionHandler)
}
