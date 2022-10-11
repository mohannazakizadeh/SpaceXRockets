//
//  BookmarksViewInterface.swift
//  Bookmarks
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import UIKit

protocol BookmarksViewInterface: ViewPresenterInterface {
    func reloadCollectionView()
    func showError(with errorMessage: String)
    func setBookmarksEmptyLabelisHidden(to isHidden: Bool)
}
