//
//  CoreDataManagerProtocol.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/29/22.
//

import Foundation

protocol CoreDataManagerProtocol {
    func saveLaunch(_ launch: CoreDataLaunch)
    func getSavedLaunches() -> [CoreDataLaunch]
}
