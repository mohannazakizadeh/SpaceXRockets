//
//  LaunchDetailsInfoPresenter.swift
//  LaunchDetailsInfo
//
//  Created by mohannazakizadeh on 10/2/22.
//

import Foundation
import UIKit

final class LaunchDetailsInfoPresenter: PresenterInterface {

    var router: LaunchDetailsInfoRouterInterface!
    var interactor: LaunchDetailsInfoInteractorInterface!
    weak var view: LaunchDetailsInfoViewInterface!

    let launch: Launch

    init(launch: Launch) {
        self.launch = launch
    }

    private func configureLinks() -> [String: String] {
        var links: [String: String] = [:]
        if let wikipedia = launch.links.wikipedia {
            links["wikipedia"] = wikipedia
        }
        if let article = launch.links.article {
            links["article"] = article
        }
        if let webcast = launch.links.webcast {
            links["webcast"] = webcast
        }
        return links
    }

    private func configureStatusStack() {
        if launch.success != nil {
            view.addStatusStack()
        }
    }
    private func configureDetailsStack() {
        if launch.details != nil {
            view.addDetailsStack()
        }
    }
}

extension LaunchDetailsInfoPresenter: LaunchDetailsInfoPresenterRouterInterface {

}

extension LaunchDetailsInfoPresenter: LaunchDetailsInfoPresenterInteractorInterface {

}

extension LaunchDetailsInfoPresenter: LaunchDetailsInfoPresenterViewInterface {

    func viewDidLoad() {
        configureStatusStack()
        configureDetailsStack()
        view.updateLinksView(with: configureLinks())
    }

    func saveLaunch() {
        let coreDataLaunch = CoreDataLaunch(name: launch.name,
                                            success: launch.success ?? false,
                                            details: launch.details ?? "",
                                            flightNumber: launch.flightNumber,
                                            date: launch.getFormattedDate() ?? "",
                                            launchIconLink: launch.links.patch.small,
                                            launchImageLink: launch.links.patch.large,
                                            wikipedia: launch.links.webcast ?? "",
                                            article: launch.links.wikipedia ?? "",
                                            webcast: launch.links.article ?? "")
        CoreDataManager().saveLaunch(coreDataLaunch)
        view.updateBookmark(with: isSaved)
    }

    func linkButtonTapped(_ name: String) {
        switch name {
        case "wikipedia":
            if let url = URL(string: launch.links.wikipedia ?? "") {
                router.openLink(url)
            }
        case "webcast":
            if let url = URL(string: launch.links.webcast ?? "") {
                router.openLink(url)
            }
        case "article":
            if let url = URL(string: launch.links.article ?? "") {
                router.openLink(url)
            }
        default:
            break
        }
    }

    var isSaved: Bool {
        let savedLaunches = CoreDataManager().getSavedLaunches()
        return savedLaunches.contains { launch in
            self.launch.flightNumber == launch.flightNumber
        }
    }

    var statusColor: UIColor? {
        return launch.getState()?.color
    }

    var launchState: String? {
        return launch.getState()?.rawValue
    }

    var launchDetails: String? {
        return launch.details
    }

    var launchName: String {
        return launch.name
    }

    var flightNumber: String? {
        return "\(launch.flightNumber)"
    }

    var launchDate: String? {
        return launch.getFormattedDate()
    }

}
