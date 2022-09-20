//
//  BookmarksRouter.swift
//  Bookmarks
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import UIKit

final class BookmarksRouter: RouterInterface {

    weak var presenter: BookmarksPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension BookmarksRouter: BookmarksRouterInterface {

}
