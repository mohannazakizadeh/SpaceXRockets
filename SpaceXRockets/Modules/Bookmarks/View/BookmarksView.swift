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
    lazy var collectionView: UICollectionView = setupCollectionView()
    private let launchesImagesCache = NSCache<NSNumber, UIImage>()

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

    // MARK: - Theme

    func applyTheme() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .secondarySystemBackground
    }

    // MARK: - Actions

    // MARK: - Private functions

    private func setupView() {
        configureNavigation()
    }

    // function to setup and configure collectionView details
    private func setupCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.estimatedItemSize = CGSize(width: 330, height: 230)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchCell",
                                                            for: indexPath)
                as? LaunchCell else { return UICollectionViewCell() }
        let launch = presenter.getLaunch(for: indexPath.row)
        cell.flightNumber = "\(launch.flightNumber)"
        cell.date = launch.date
        cell.launchState = launch.getState()
        cell.information = launch.details
        return cell
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
}
