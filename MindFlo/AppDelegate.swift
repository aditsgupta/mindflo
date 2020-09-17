//
//  AppDelegate.swift
//  MindFlo
//
//  Created by Adit Gupta on 06/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        
        FirebaseApp.configure() //Analytics
        return true
    }
    //Actions from Notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //Tap on notification
        if response.notification.request.content.categoryIdentifier == "dailyCheckin" {
            //Tap on notification
            NotificationCenter.default.post(name: NSNotification.Name("chooseMood"), object: nil)
            Analytics.logEvent("Checkin_writeMF", parameters: ["type" : response.notification.request.identifier, "source" : "Notif_tap"]) //Firebase
            
            //Forcetouch on notification actions
            switch response.actionIdentifier {
            case "write":
                NotificationCenter.default.post(name: NSNotification.Name("chooseMood"), object: nil)
                Analytics.logEvent("writeMF_Checkin", parameters: ["type" : response.notification.request.identifier, "source" : "Notif_forceTouch_actions"]) //Firebase
            case "writeWithMood":
                NotificationCenter.default.post(name: NSNotification.Name("chooseMood"), object: nil)
                Analytics.logEvent("writeMF_Checkin", parameters: ["type" : response.notification.request.identifier, "source" : "Notif_forceTouch_actions"]) //Firebase
            default:
                break
            }
        }
        
//        switch response.notification.request.identifier {
//        case "morningCheckin":
//            NotificationCenter.default.post(name: NSNotification.Name("chooseMood"), object: nil)
//            Analytics.logEvent("writeMF_Checkin", parameters: ["type" : "Morning", "source" : "Notif_tap"]) //Firebase
//
//        case "eveningCheckin":
//            NotificationCenter.default.post(name: NSNotification.Name("chooseMood"), object: nil)
//            Analytics.logEvent("writeMF_Checkin", parameters: ["type" : "Evening", "source" : "Notif_tap"]) //Firebase
//
//        case "customCheckin":
//            NotificationCenter.default.post(name: NSNotification.Name("chooseMood"), object: nil)
//            Analytics.logEvent("writeMF_Checkin", parameters: ["type" : "Custom", "source" : "Notif_tap"]) //Firebase
//
//        default:
//            break
//        }
        
        // Always call the completion handler when done.
        completionHandler()
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "MindFlo")
        //print(container.persistentStoreDescriptions.first?.url)
        // get the store description
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Could not retrieve a persistent store description.")
        }
        // initialize the CloudKit schema
        let id = "iCloud.MindFlo"
        let options = NSPersistentCloudKitContainerOptions(containerIdentifier: id)
        //options.shouldInitializeSchema = true // toggle to false when done
        description.cloudKitContainerOptions = options
        //Fin initialization
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        
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

