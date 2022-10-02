//
//  LaunchDetailsPresenter.swift
//  LaunchDetails
//
//  Created by Mohanna Zakizadeh on 9/24/22.
//

import Foundation

final class LaunchDetailsPresenter: PresenterInterface {

    var router: LaunchDetailsRouterInterface!
    var interactor: LaunchDetailsInteractorInterface!
    weak var view: LaunchDetailsViewInterface!

}

extension LaunchDetailsPresenter: LaunchDetailsPresenterRouterInterface {

}

extension LaunchDetailsPresenter: LaunchDetailsPresenterInteractorInterface {

}

extension LaunchDetailsPresenter: LaunchDetailsPresenterViewInterface {

    func viewDidLoad() {

    }

}
