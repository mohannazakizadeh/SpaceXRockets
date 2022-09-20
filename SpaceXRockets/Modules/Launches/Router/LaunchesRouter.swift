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

}
