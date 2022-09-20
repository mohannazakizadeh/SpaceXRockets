//
//  LaunchesPresenter.swift
//  Launches
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation

final class LaunchesPresenter: PresenterInterface {

    var router: LaunchesRouterInterface!
    var interactor: LaunchesInteractorInterface!
    weak var view: LaunchesViewInterface!

}

extension LaunchesPresenter: LaunchesPresenterRouterInterface {

}

extension LaunchesPresenter: LaunchesPresenterInteractorInterface {

}

extension LaunchesPresenter: LaunchesPresenterViewInterface {

    func viewDidLoad() {

    }

}
