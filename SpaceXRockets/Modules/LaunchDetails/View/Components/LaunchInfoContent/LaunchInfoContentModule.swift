//
//  LaunchInfoContentModule.swift
//  LaunchInfoContent
//
//  Created by mohannazakizadeh on 10/2/22.
//

import UIKit

// MARK: - module builder

final class LaunchInfoContentModule: ModuleInterface {

    typealias View = LaunchInfoContentView
    typealias Presenter = LaunchInfoContentPresenter
    typealias Router = LaunchInfoContentRouter
    typealias Interactor = LaunchInfoContentInteractor

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
