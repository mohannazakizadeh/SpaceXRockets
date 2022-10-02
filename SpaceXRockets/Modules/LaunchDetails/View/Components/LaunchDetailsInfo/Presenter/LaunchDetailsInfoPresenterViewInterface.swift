//
//  LaunchDetailsInfoPresenterViewInterface.swift
//  LaunchDetailsInfo
//
//  Created by mohannazakizadeh on 10/2/22.
//

import Foundation
import UIKit

protocol LaunchDetailsInfoPresenterViewInterface: PresenterViewInterface {
    func viewDidLoad()
    func saveLaunch()
    func linkButtonTapped(_ name: String)
    var isSaved: Bool { get }
    var statusColor: UIColor? { get }
    var launchState: String? { get }
    var launchDetails: String? { get }
    var launchName: String { get }
    var flightNumber: String? { get }
    var launchDate: String? { get }
}
