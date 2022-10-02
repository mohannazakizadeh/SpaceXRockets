//
//  LaunchDetailsInfoViewInterface.swift
//  LaunchDetailsInfo
//
//  Created by mohannazakizadeh on 10/2/22.
//

import UIKit

protocol LaunchDetailsInfoViewInterface: ViewPresenterInterface {
    func updateBookmark(with isSaved: Bool)
    func updateLinksView(with links: [String: String])
    func addStatusStack()
    func addDetailsStack()
}
