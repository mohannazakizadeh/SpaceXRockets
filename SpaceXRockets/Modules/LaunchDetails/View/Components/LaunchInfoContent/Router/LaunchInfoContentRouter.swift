//
//  LaunchInfoContentRouter.swift
//  LaunchInfoContent
//
//  Created by mohannazakizadeh on 10/2/22.
//

import UIKit

final class LaunchInfoContentRouter: RouterInterface {

    weak var presenter: LaunchInfoContentPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension LaunchInfoContentRouter: LaunchInfoContentRouterInterface {

}
