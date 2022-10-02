//
//  LaunchDetailsRouter.swift
//  LaunchDetails
//
//  Created by Mohanna Zakizadeh on 9/24/22.
//

import UIKit

final class LaunchDetailsRouter: RouterInterface {

    weak var presenter: LaunchDetailsPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension LaunchDetailsRouter: LaunchDetailsRouterInterface {

}
