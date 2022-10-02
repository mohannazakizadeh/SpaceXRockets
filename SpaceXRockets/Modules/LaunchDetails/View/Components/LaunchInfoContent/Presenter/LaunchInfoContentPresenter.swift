//
//  LaunchInfoContentPresenter.swift
//  LaunchInfoContent
//
//  Created by mohannazakizadeh on 10/2/22.
//

import Foundation
import UIKit

final class LaunchInfoContentPresenter: PresenterInterface {

    var router: LaunchInfoContentRouterInterface!
    var interactor: LaunchInfoContentInteractorInterface!
    weak var view: LaunchInfoContentViewInterface!

    let launch: Launch

    init(launch: Launch) {
        self.launch = launch
    }

}

extension LaunchInfoContentPresenter: LaunchInfoContentPresenterRouterInterface {

}

extension LaunchInfoContentPresenter: LaunchInfoContentPresenterInteractorInterface {

}

extension LaunchInfoContentPresenter: LaunchInfoContentPresenterViewInterface {

    func viewDidLoad() {

    }

    func getLaunchImage(completion: @escaping (UIImage) -> Void) {
        let stringURL = launch.links.patch.large
        UIImage().getImage(from: stringURL) { image in
            completion(image)
        }
    }
}
