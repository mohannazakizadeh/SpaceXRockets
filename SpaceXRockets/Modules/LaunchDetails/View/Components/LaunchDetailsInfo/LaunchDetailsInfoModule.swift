//
//  LaunchDetailsInfoModule.swift
//  LaunchDetailsInfo
//
//  Created by mohannazakizadeh on 10/2/22.
//

import UIKit

// MARK: - module builder

final class LaunchDetailsInfoModule: ModuleInterface {

    typealias View = LaunchDetailsInfoView
    typealias Presenter = LaunchDetailsInfoPresenter
    typealias Router = LaunchDetailsInfoRouter
    typealias Interactor = LaunchDetailsInfoInteractor

    func build(launch: Launch) -> UIViewController {
        let view = View()
        let interactor = Interactor()
        let presenter = Presenter(launch: launch)
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view

        return view
    }
}
