//
//  LaunchDetailsInfoView.swift
//  LaunchDetailsInfo
//
//  Created by mohannazakizadeh on 10/2/22.
//

import UIKit

final class LaunchDetailsInfoView: UIViewController, ViewInterface {

	var presenter: LaunchDetailsInfoPresenterViewInterface!

	// MARK: - Properties
    var launchNameLabel: UILabel!
    var dateLabel: UILabel!
    var nameDateStackView: UIStackView!

    var flightNumberLabel: UILabel!
    var flightNumberTitleLabel: UILabel!
    var flightNumberStackView: UIStackView!

    var statusLabel: UILabel?
    var statusTitleLabel: UILabel?
    var statusStackView: UIStackView?

    var bookmarkButton: UIButton!
    var bookmarkTitleLabel: UILabel!
    var bookmarkStackView: UIStackView!

    var launchInfoStackView: UIStackView!

    lazy var linksTitleLabel: UILabel! = setupLabel(with: "Links")
    var linksStackView: UIStackView!
    var linksTotalStackView: UIStackView!

    var detailsTitleLabel: UILabel?
    var detailsLabel: UILabel?
    var detailsStackView: UIStackView?

    var totalStackView: UIStackView!

	// MARK: - Initialize

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		self.applyTheme()
		self.presenter.viewDidLoad()
	}

    private func configureView() {
        launchNameLabel = setupLabel(with: presenter.launchName)
        dateLabel = setupLabel(with: presenter.launchDate)
        nameDateStackView = setupStackView(with: [launchNameLabel, dateLabel], spacing: 13, axis: .vertical)
        nameDateStackView.distribution = .equalSpacing

        flightNumberLabel = setupLabel(with: presenter.flightNumber)
        flightNumberTitleLabel = setupLabel(with: "Flight Nr.")
        flightNumberStackView = setupStackView(with: [flightNumberLabel, flightNumberTitleLabel],
                                               spacing: 8, axis: .vertical)
        flightNumberStackView.alignment = .center

        bookmarkButton = setupBookmarkButton()
        bookmarkTitleLabel = setupLabel(with: "Bookmark")
        bookmarkStackView = setupStackView(with: [bookmarkButton, bookmarkTitleLabel], spacing: 4, axis: .vertical)
        bookmarkStackView.alignment = .center

        launchInfoStackView = setupStackView(with: [flightNumberStackView, bookmarkStackView],
                                            spacing: 0,
                                            axis: .horizontal)
        launchInfoStackView.layer.cornerRadius = 14
        launchInfoStackView.alignment = .center

        totalStackView = setupStackView(with: [nameDateStackView, launchInfoStackView],
                                        spacing: 32,
                                        axis: .vertical)

        setTotalStackView(in: self.view)

        self.applyTheme()
    }

    // MARK: - Theme

    func applyTheme() {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 14

        launchNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        dateLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 15)
        dateLabel.textColor = .secondaryLabel

        flightNumberLabel.font = UIFont.boldSystemFont(ofSize: 22)
        flightNumberTitleLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 15)
        flightNumberTitleLabel.textColor = .secondaryLabel

        bookmarkButton.tintColor = .label
        bookmarkTitleLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 15)
        bookmarkTitleLabel.textColor = .secondaryLabel

        linksTitleLabel.font = UIFont.boldSystemFont(ofSize: 28)

        statusLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        statusLabel?.textColor = presenter.statusColor
        statusTitleLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 15)
        statusTitleLabel?.textColor = .secondaryLabel
        launchInfoStackView.backgroundColor = .secondarySystemBackground

        detailsTitleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
    }

    @objc func saveLaunch() {
        presenter.saveLaunch()
    }

    @objc func linkButtonTapped(sender: UIButton) {
        presenter.linkButtonTapped(sender.titleLabel?.text ?? "")
    }

    // MARK: - Private functions

    private func setupLabel(with text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        return label
    }

    private func setupBookmarkButton() -> UIButton {
        let button = UIButton()
        let image = presenter.isSaved ? UIImage(systemName: "bookmark.fill")
        : UIImage(systemName: "bookmark")
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 30)
        ])
        button.addTarget(self, action: #selector(saveLaunch), for: .touchUpInside)
        return button
    }

    private func setupLinkButton(name: String, link: String) -> UIButton {
        let button = UIButton(configuration: .tinted())
        button.setTitle(name, for: .normal)
        button.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        return button
    }

    private func setupStackView(with views: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }

    private func setTotalStackView(in view: UIView? = nil) {
        if let view = view {
            view.addSubview(totalStackView)
            totalStackView.alignment = .leading
            totalStackView.translatesAutoresizingMaskIntoConstraints = false
            totalStackView.layer.cornerRadius = 14

            NSLayoutConstraint.activate([
                totalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
                totalStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
                totalStackView.widthAnchor.constraint(equalTo: view.widthAnchor),

                launchInfoStackView.heightAnchor.constraint(equalToConstant: 85),
                launchInfoStackView.leadingAnchor.constraint(equalTo: totalStackView.leadingAnchor, constant: 16),
                launchInfoStackView.trailingAnchor.constraint(equalTo: totalStackView.trailingAnchor, constant: -16),

                nameDateStackView.leadingAnchor.constraint(equalTo: totalStackView.leadingAnchor, constant: 16),
                nameDateStackView.trailingAnchor.constraint(equalTo: totalStackView.trailingAnchor, constant: -16)
            ])
        }
    }

}

extension LaunchDetailsInfoView: LaunchDetailsInfoViewInterface {

    func updateLinksView(with links: [String: String]) {
        if links.isEmpty { return }
        linksStackView = setupStackView(with: [], spacing: 10, axis: .horizontal)
        linksStackView.alignment = .center
        linksStackView.distribution = .fillEqually

        for (name, link) in links {
           let button = setupLinkButton(name: name, link: link)
            linksStackView.addArrangedSubview(button)
        }

        linksTotalStackView = setupStackView(with: [linksTitleLabel, linksStackView], spacing: 16, axis: .vertical)
        totalStackView.insertArrangedSubview(linksTotalStackView, at: 2)
    }

    func updateBookmark(with isSaved: Bool) {
        let image = isSaved ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
        bookmarkButton.setBackgroundImage(image, for: .normal)
    }

    func addStatusStack() {
        statusLabel = setupLabel(with: presenter.launchState)
        statusTitleLabel = setupLabel(with: "Status")
        statusStackView = setupStackView(with: [statusLabel!, statusTitleLabel!], spacing: 8, axis: .vertical)
        statusStackView?.alignment = .center
        launchInfoStackView.insertArrangedSubview(statusStackView!, at: 1)
        applyTheme()
    }

    func addDetailsStack() {
        detailsTitleLabel = setupLabel(with: "Details")
        detailsLabel = setupLabel(with: presenter.launchDetails)
        detailsStackView = setupStackView(with: [detailsTitleLabel!, detailsLabel!], spacing: 16, axis: .vertical)
        detailsStackView?.distribution = .fillProportionally
        totalStackView.addArrangedSubview(detailsStackView!)
        NSLayoutConstraint.activate([
            detailsStackView!.leadingAnchor.constraint(equalTo: totalStackView.leadingAnchor, constant: 16),
            detailsStackView!.trailingAnchor.constraint(equalTo: totalStackView.trailingAnchor, constant: -16)
        ])
        applyTheme()
    }

}
