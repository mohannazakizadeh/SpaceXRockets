//
//  LaunchDetailsModule.swift
//  LaunchDetails
//
//  Created by Mohanna Zakizadeh on 9/24/22.
//

import UIKit

// MARK: - module builder

final class LaunchDetailsModule: ModuleInterface {

    typealias View = LaunchDetailsView
    typealias Presenter = LaunchDetailsPresenter
    typealias Router = LaunchDetailsRouter
    typealias Interactor = LaunchDetailsInteractor

    func build(launch: Launch) -> UIViewController {
        guard let launchInfoContentView = LaunchInfoContentModule().build(launch: launch) as? LaunchInfoContentView
        else {
            return UIViewController()
        }
        guard let launchDetailsInfoView = LaunchDetailsInfoModule().build(launch: launch) as? LaunchDetailsInfoView
        else {
            return UIViewController()
        }

        let view = View(contentViewController: launchInfoContentView,
                        bottomSheetViewController: launchDetailsInfoView,
                        bottomSheetConfiguration: .init(height: UIScreen.main.bounds.height*0.8,
                                                        initialOffset: UIScreen.main.bounds.height / 2.2))
        let navigation = UINavigationController(rootViewController: view)

        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = navigation

        return navigation
    }
}
