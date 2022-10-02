//
//  LaunchInfoContentView.swift
//  LaunchInfoContent
//
//  Created by mohannazakizadeh on 10/2/22.
//

import UIKit

final class LaunchInfoContentView: UIViewController, ViewInterface {

	var presenter: LaunchInfoContentPresenterViewInterface!

    // MARK: - Properties
    lazy var imageView: UIImageView = setupImageView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        self.applyTheme()
        self.presenter.viewDidLoad()
    }

    // MARK: - Theme
    func applyTheme() {
        view.backgroundColor = .secondarySystemBackground
    }

    // MARK: - Private functions
    private func setupImageView() -> UIImageView {
        let imageView = UIImageView()
        presenter.getLaunchImage { image in
            imageView.image = image
        }
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }

    private func setupView() {
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: -((UIScreen.main.bounds.height / 2.2) + 32))
        ])
    }
}

extension LaunchInfoContentView: LaunchInfoContentViewInterface {

}
