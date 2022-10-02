//
//  LaunchesModule.swift
//  Launches
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import UIKit

// MARK: - module builder

final class LaunchesModule: ModuleInterface {

    typealias View = LaunchesView
    typealias Presenter = LaunchesPresenter
    typealias Router = LaunchesRouter
    typealias Interactor = LaunchesInteractor

    func build() -> UIViewController {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [View()]
        guard let view = navigationController.topViewController as? View else {
            return View()
        }
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = navigationController

        return navigationController
    }
}
