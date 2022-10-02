//
//  BookmarksPresenter.swift
//  Bookmarks
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation
import UIKit

final class BookmarksPresenter: PresenterInterface {

    var router: BookmarksRouterInterface!
    var interactor: BookmarksInteractorInterface!
    weak var view: BookmarksViewInterface!

    private var launches: [CoreDataLaunch] = []

}

extension BookmarksPresenter: BookmarksPresenterRouterInterface {

}

extension BookmarksPresenter: BookmarksPresenterInteractorInterface {

}

extension BookmarksPresenter: BookmarksPresenterViewInterface {

    func viewDidLoad() {
        getSavedLaunches()
    }

    func getLaunch(for index: Int) -> CoreDataLaunch {
        return launches[index]
    }

    func getSavedLaunches() {
        launches = CoreDataManager().getSavedLaunches()
        view.reloadCollectionView()
    }

    func getLaunchImage(index: Int, completion: @escaping (UIImage) -> Void) {
        if self.launches.indices.contains(index) {
            let stringURL = launches[index].launchIconLink
            UIImage().getImage(from: stringURL) { image in
                completion(image)
            }
        }
    }

    func didSelectLaunch(at index: Int) {
        if launches.indices.contains(index) {
            let coreDataLaunch = launches[index]
            let wikipedia = coreDataLaunch.wikipedia.isEmpty ? nil : coreDataLaunch.wikipedia
            let webcast = coreDataLaunch.webcast.isEmpty ? nil : coreDataLaunch.webcast
            let article = coreDataLaunch.article.isEmpty ? nil : coreDataLaunch.article
            let links = Links(patch: Patch(small: coreDataLaunch.launchIconLink,
                                           large: coreDataLaunch.launchImageLink),
                              webcast: webcast,
                              article: article,
                              wikipedia: wikipedia)
            let details = coreDataLaunch.details.isEmpty ? nil : coreDataLaunch.details
            let launch = Launch(links: links,
                                rocket: "",
                                success: coreDataLaunch.success,
                                details: details,
                                flightNumber: coreDataLaunch.flightNumber,
                                name: coreDataLaunch.name,
                                dateLocal: coreDataLaunch.date)
            router.showLaunchDetail(for: launch)
        }
    }

    var numberOfLaunches: Int {
        return launches.count
    }

}
