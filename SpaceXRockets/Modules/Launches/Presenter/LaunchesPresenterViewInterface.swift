//
//  LaunchesPresenterViewInterface.swift
//  Launches
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation
import UIKit

protocol LaunchesPresenterViewInterface: PresenterViewInterface {
    func viewDidLoad()
    func getLaunches()
    func getLaunchInformation(for index: Int) -> (Launch, Bool)
    func getLaunchImage(index: Int, completion: @escaping (UIImage) -> Void)
    func didSelectLaunch(at index: Int)
    var numberOfLaunches: Int { get }
}
