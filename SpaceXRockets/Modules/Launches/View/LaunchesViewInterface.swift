//
//  LaunchesViewInterface.swift
//  Launches
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import UIKit

protocol LaunchesViewInterface: ViewPresenterInterface {
    func reloadCollectionView()
    func showError(with errorMessage: String)
}
