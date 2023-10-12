//
//  AppDelegate.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 9/22/23.
//

import UIKit
import CoreData
import RealmSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    static var shared: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    var realm: Realm!
    var realmConfig = Realm.Configuration()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let realmURL = realmConfig.fileURL{
            print(realmURL)
        }
          do {
              realm = try Realm()
          } catch {
              print("Error initializing Realm: \(error)")
          }

                let config = Realm.Configuration(
                    schemaVersion: 9
              )

         Realm.Configuration.defaultConfiguration = config
          return true
      }


    // MARK: UISceneSession Lifecycle

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "golfTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
     
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
              
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

