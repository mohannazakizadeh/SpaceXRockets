//
//  LaunchState.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/20/22.
//

import Foundation
import UIKit

enum LaunchState: String {
    case success
    case failure

    var icon: UIImage? {
        switch self {
        case .success:
            return UIImage(systemName: "checkmark.square")?.withRenderingMode(.alwaysTemplate)
        case .failure:
            return UIImage(systemName: "xmark.app")?.withRenderingMode(.alwaysTemplate)
        }
    }
    var color: UIColor? {
        switch self {
        case .success:
            return .systemGreen
        case .failure:
            return .systemRed
        }
    }
}
