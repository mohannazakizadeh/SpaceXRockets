//
//  BookmarksPresenterViewInterface.swift
//  Bookmarks
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation
import UIKit

protocol BookmarksPresenterViewInterface: PresenterViewInterface {
    func viewDidLoad()
    func getSavedLaunches()
    func getLaunchImage(index: Int, completion: @escaping (UIImage) -> Void)
    func getLaunch(for index: Int) -> CoreDataLaunch
    func didSelectLaunch(at index: Int)
    var numberOfLaunches: Int { get }
}
