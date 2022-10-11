//
//  BookmarksView.swift
//  Bookmarks
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import UIKit

final class BookmarksView: UIViewController, ViewInterface {

    var presenter: BookmarksPresenterViewInterface!

    // MARK: - Properties
    private lazy var collectionView: UICollectionView = setupCollectionView()
    private let launchesImagesCache = NSCache<NSNumber, UIImage>()
    private lazy var emptyLabel: UILabel = setupEmptyLabel()
    // MARK: - Initializer

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.applyTheme()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter.getSavedLaunches()
    }

    override func viewWillDisappear(_ animated: Bool) {
        presenter.removeDeletedLaunches()
    }

    // MARK: - Theme

    func applyTheme() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .secondarySystemBackground
        emptyLabel.font = UIFont.boldSystemFont(ofSize: 22)
        emptyLabel.textColor = .secondaryLabel
    }

    // MARK: - Private functions

    private func setupView() {
        configureNavigation()
    }

    private func setupEmptyLabel() -> UILabel {
        let label = UILabel()
        label.text = "Your Bookmarks is empty!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return label
    }

    // function to setup and configure collectionView details
    private func setupCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.estimatedItemSize = CGSize(width: screenWidth - 32, height: 130)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionView.register(UINib(nibName: String(describing: LaunchCell.self), bundle: nil),
                                forCellWithReuseIdentifier: String(describing: LaunchCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }

    // function to setup and configure navigation details
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Bookmarks"
    }

}

extension BookmarksView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfLaunches
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        // for caching cell movie image
        guard let cell = cell as? LaunchCell else { return }
        let cellNumber = NSNumber(value: indexPath.item)

        if let cachedImage = self.launchesImagesCache.object(forKey: cellNumber) {
            cell.launchImage = cachedImage
        } else {
            self.presenter.getLaunchImage(index: indexPath.row, completion: { [weak self] (image) in
                if collectionView.indexPath(for: cell) == indexPath {
                    cell.launchImage = image
                }
                self?.launchesImagesCache.setObject(image, forKey: cellNumber)
            })
        }

    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LaunchCell.self),
                                                            for: indexPath)
                as? LaunchCell else { return UICollectionViewCell() }
        let launchInformation = presenter.getLaunchInformation(for: indexPath.row)
        let launch = launchInformation.0
        cell.flightNumber = "\(launch.flightNumber)"
        cell.date = launch.date
        cell.launchState = launch.getState()
        cell.hasDetails = launchInformation.1
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        presenter.configureContextMenu(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectLaunch(at: indexPath.row)
    }
}

extension BookmarksView: BookmarksViewInterface {
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }

    func showError(with errorMessage: String) {
        let alert = UIAlertController(title: "Error Ocurred", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.presenter.getSavedLaunches()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }

    func setBookmarksEmptyLabelisHidden(to isHidden: Bool) {
        emptyLabel.isHidden = isHidden
    }
}
