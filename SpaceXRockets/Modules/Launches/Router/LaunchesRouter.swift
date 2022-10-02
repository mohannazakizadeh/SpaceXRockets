//
//  LaunchesRouter.swift
//  Launches
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import UIKit

final class LaunchesRouter: RouterInterface {

    weak var presenter: LaunchesPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension LaunchesRouter: LaunchesRouterInterface {
    func showLaunchDetail(for launch: Launch) {
        let detailsViewController = LaunchDetailsModule().build(launch: launch)
        viewController?.show(detailsViewController, sender: nil)
    }

}
