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

    private func deletefromBookmarks(_ index: Int) {
        self.launches.remove(at: index)
        view.reloadCollectionView()

        if launches.isEmpty {
            view.setBookmarksEmptyLabelisHidden(to: false)
        }
    }
}

extension BookmarksPresenter: BookmarksPresenterRouterInterface {

}

extension BookmarksPresenter: BookmarksPresenterInteractorInterface {

}

extension BookmarksPresenter: BookmarksPresenterViewInterface {

    func viewDidLoad() {
        getSavedLaunches()
    }

    func getLaunchInformation(for index: Int) -> (CoreDataLaunch, Bool) {
        let launch = launches[index]
        if !launch.details.isEmpty {
            return (launch, true)
        }
        return (launch, false)
    }

    func getSavedLaunches() {
        launches = CoreDataManager().getSavedLaunches()
        if launches.isEmpty {
            view.setBookmarksEmptyLabelisHidden(to: false)
        } else {
            view.setBookmarksEmptyLabelisHidden(to: true)
            view.reloadCollectionView()
        }
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

    func configureContextMenu(_ index: Int) -> UIContextMenuConfiguration {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_) -> UIMenu? in

            let viewDetails = UIAction(title: "View Details",
                                       image: UIImage(systemName: "info.circle.fill"),
                                       identifier: nil,
                                       discoverabilityTitle: nil, state: .off) { (_) in
                self.didSelectLaunch(at: index)
            }
            let remove = UIAction(title: "Remove from bookmarks",
                                  image: UIImage(systemName: "trash"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive, state: .off) { (_) in
                self.deletefromBookmarks(index)
            }
            let launch = self.getLaunchInformation(for: index).0
            return UIMenu(title: "Flight No.: \(launch.flightNumber)",
                          image: nil, identifier: nil,
                          options: UIMenu.Options.displayInline, children: [viewDetails, remove])

        }
        return context
    }

    func removeDeletedLaunches() {
        CoreDataManager().saveLaunches(launches: launches)
    }

    var numberOfLaunches: Int {
        return launches.count
    }

}
