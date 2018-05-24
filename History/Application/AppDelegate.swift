//
//  AppDelegate.swift
//  History
//
//  Created by Cloudream on 07/03/2018.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import CoreData
import AVOSCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // applicationId 即 App Id，applicationKey 是 App Key
        let dev_cn_appID = "FCHudlonDJ4mzppWt6xSuRH7-gzGzoHsz"
        let dev_cn_appKey = "Wf1tUQlil0vn7FPeleN1KCyi"

        AVOSCloud.setApplicationId(dev_cn_appID, clientKey: dev_cn_appKey)
        AVOSCloud.setAllLogsEnabled(true)
        
//        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        UIApplication.shared.setMinimumBackgroundFetchInterval(36000)

        setupData()
        
        // https://coderwall.com/p/dyqrfa/customize-navigation-bar-appearance-with-swift
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent

        return true
    }

    // https://developer.apple.com/documentation/uikit/core_app/managing_your_app_s_life_cycle/preparing_your_app_to_run_in_the_background/updating_your_app_with_background_app_refresh
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        setupData()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "History")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func setupData() {
        LocalDataManager.sharedInstance.clearAll()
        PersonManager.sharedInstance.fetchAllPeopleFromLC { (objects, error) in
            if error == nil && objects != nil {
                for personObject in objects! {
                    if let person = CoreDataManager.savePerson(personObject: personObject as! AVObject) {
                        LocalDataManager.sharedInstance.addRecord(person: person)
                    }
//                    CoreDataManager.sharedInstance.savePerson(personObject: personObject as! AVObject)
//                    LocalDataManager.sharedInstance.addRecord(personObject: personObject as! AVObject)
                }
            } else {
                print(error?.localizedDescription)
            }
        }
        
        EventManager.sharedInstance.fetchAllEventsFromLC { (objects, error) in
            if error == nil && objects != nil {
                for eventObject in objects! {
//                    if let event = CoreDataManager.sharedInstance.saveEvent(eventObject: eventObject as! AVObject) {
//                        LocalDataManager.sharedInstance.addRecord(event: event)
//                    }
                    CoreDataManager.saveEvent(eventObject: eventObject as! AVObject)
                    LocalDataManager.sharedInstance.addRecord(eventObject: eventObject as! AVObject)
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}

