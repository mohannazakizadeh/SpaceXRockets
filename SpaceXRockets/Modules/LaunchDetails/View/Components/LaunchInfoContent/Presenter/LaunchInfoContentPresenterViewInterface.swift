//
//  LaunchInfoContentPresenterViewInterface.swift
//  LaunchInfoContent
//
//  Created by mohannazakizadeh on 10/2/22.
//

import Foundation
import UIKit

protocol LaunchInfoContentPresenterViewInterface: PresenterViewInterface {
    func viewDidLoad()
    func getLaunchImage(completion: @escaping (UIImage) -> Void)
}
