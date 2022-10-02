//
//  TabBarController.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Properties
    var launchesViewController: UIViewController!
    var bookmarksViewController: UIViewController!

    let rocketIcon = UIImage(named: "rocket")
    let bookmarkIcon = UIImage(systemName: "bookmark")

    override func viewDidLoad() {
        super.viewDidLoad()

        launchesViewController = setupLaunchesViewController()
        bookmarksViewController = setupBookmarksViewController()

        self.viewControllers = [launchesViewController, bookmarksViewController]
        self.toolbarItems = []
    }

    // MARK: - Private functions

    private func setupLaunchesViewController() -> UIViewController {
        let launchesViewController = LaunchesModule().build()
        let tabBarItem = UITabBarItem(title: "Launches", image: rocketIcon, tag: 0)
        launchesViewController.tabBarItem = tabBarItem
        return launchesViewController
    }

    private func setupBookmarksViewController() -> UIViewController {
        let bookmarksViewController = BookmarksModule().build()
        let tabBarItem = UITabBarItem(title: "Bookmarks", image: bookmarkIcon,
                                      selectedImage: UIImage(systemName: "bookmark.fill"))
        bookmarksViewController.tabBarItem = tabBarItem
        return bookmarksViewController
    }
}
