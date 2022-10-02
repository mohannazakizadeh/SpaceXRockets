//
//  CoreDataManager.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/29/22.
//
import CoreData
import Foundation
import UIKit

final class CoreDataManager: CoreDataManagerProtocol {
    func saveLaunch(_ launch: CoreDataLaunch) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//         prevents core data from saving repititious data
        let savedLaunches = getSavedLaunches()
        if savedLaunches.contains(where: {$0.flightNumber == launch.flightNumber}) {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "SavedLaunch", in: managedContext)!

        let savedLaunch = NSManagedObject(entity: entity, insertInto: managedContext)

        savedLaunch.setValue(launch.name, forKey: "name")
        savedLaunch.setValue(launch.success, forKey: "success")
        savedLaunch.setValue(launch.details, forKey: "details")
        savedLaunch.setValue(launch.flightNumber, forKey: "flightNumber")
        savedLaunch.setValue(launch.date, forKey: "date")
        savedLaunch.setValue(launch.launchIconLink, forKey: "launchIconLink")
        savedLaunch.setValue(launch.launchImageLink, forKey: "launchImageLink")
        savedLaunch.setValue(launch.wikipedia, forKey: "wikipedia")
        savedLaunch.setValue(launch.webcast, forKey: "webcast")
        savedLaunch.setValue(launch.article, forKey: "article")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }

    func getSavedLaunches() -> [CoreDataLaunch] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        var launches = [CoreDataLaunch]()
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedLaunch")

        do {
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects {
                launches.append(CoreDataLaunch(name: object.value(forKey: "name") as? String ?? "",
                                               success: object.value(forKey: "success") as? Bool ?? false,
                                               details: object.value(forKey: "details") as? String ?? "",
                                               flightNumber: object.value(forKey: "flightNumber") as? Int ?? 0,
                                               date: object.value(forKey: "date") as? String ?? "",
                                               launchIconLink: object.value(forKey: "launchIconLink") as? String ?? "",
                                               launchImageLink: object.value(forKey: "launchImageLink") as? String ?? ""
                                               ,
                                               wikipedia: object.value(forKey: "wikipedia") as? String ?? "",
                                               article: object.value(forKey: "article") as? String ?? "",
                                               webcast: object.value(forKey: "webcast") as? String ?? ""))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return launches
    }

}
