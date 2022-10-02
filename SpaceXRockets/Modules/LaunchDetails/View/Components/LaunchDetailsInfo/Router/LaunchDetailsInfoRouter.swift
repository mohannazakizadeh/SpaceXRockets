//
//  LaunchDetailsInfoRouter.swift
//  LaunchDetailsInfo
//
//  Created by mohannazakizadeh on 10/2/22.
//

import UIKit

final class LaunchDetailsInfoRouter: RouterInterface {

    weak var presenter: LaunchDetailsInfoPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension LaunchDetailsInfoRouter: LaunchDetailsInfoRouterInterface {
    func openLink(_ url: URL) {
        UIApplication.shared.open(url)
    }

}
