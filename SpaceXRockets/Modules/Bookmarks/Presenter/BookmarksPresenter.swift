//
//  BookmarksPresenter.swift
//  Bookmarks
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation

final class BookmarksPresenter: PresenterInterface {

    var router: BookmarksRouterInterface!
    var interactor: BookmarksInteractorInterface!
    weak var view: BookmarksViewInterface!

}

extension BookmarksPresenter: BookmarksPresenterRouterInterface {

}

extension BookmarksPresenter: BookmarksPresenterInteractorInterface {

}

extension BookmarksPresenter: BookmarksPresenterViewInterface {

    func viewDidLoad() {

    }

}
