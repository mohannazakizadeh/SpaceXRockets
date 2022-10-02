//
//  LaunchDetailsView.swift
//  LaunchDetails
//
//  Created by Mohanna Zakizadeh on 9/24/22.
//

import UIKit

final class LaunchDetailsView: BottomSheetContainerViewController
<LaunchInfoContentView, LaunchDetailsInfoView>, ViewInterface {

	var presenter: LaunchDetailsPresenterViewInterface!

	override func viewDidLoad() {
		super.viewDidLoad()

		self.applyTheme()
	}

	// MARK: - Theme

	func applyTheme() {
        view.backgroundColor = .systemBackground
	}

}

extension LaunchDetailsView: LaunchDetailsViewInterface {

}
