//
//  LaunchesPresenter.swift
//  Launches
//
//  Created by Mohanna Zakizadeh on 9/19/22.
//

import Foundation
import UIKit

final class LaunchesPresenter: PresenterInterface {

    var router: LaunchesRouterInterface!
    var interactor: LaunchesInteractorInterface!
    weak var view: LaunchesViewInterface!

    private var launches: [Launch] = []
    private var currentPage = 1
    private var totalPages: Int?
}

extension LaunchesPresenter: LaunchesPresenterRouterInterface {

}

extension LaunchesPresenter: LaunchesPresenterInteractorInterface {

}

extension LaunchesPresenter: LaunchesPresenterViewInterface {

    func viewDidLoad() {
        getLaunches()
    }

    func getLaunch(for index: Int) -> Launch {
        return launches[index]
    }

    func getLaunches() {
        if currentPage > (totalPages ?? 2) {
            return
        }
        interactor.getLaunches(page: currentPage) { [weak self] result in
            switch result {
            case .success(let launchesData):
                self?.totalPages = launchesData.totalPages
                self?.launches.append(contentsOf: launchesData.launches)
                self?.view.reloadCollectionView()
                self?.currentPage += 1

            case .failure(let error):
                self?.view.showError(with: error.localizedDescription)
            }
        }

    }

    func getLaunchImage(index: Int, completion: @escaping (UIImage) -> Void) {
        if self.launches.indices.contains(index) {
            let stringURL = launches[index].links.patch.small
            UIImage().getImage(from: stringURL) { image in
                completion(image)
            }
        }
    }

    func didSelectLaunch(at index: Int) {
        if launches.indices.contains(index) {
            router.showLaunchDetail(for: launches[index])
        }
    }
    var numberOfLaunches: Int {
        return launches.count
    }
}
