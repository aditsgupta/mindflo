//
//  NotificationHelper.swift
//  MindFlo
//
//  Created by Adit Gupta on 09/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationsHelper {
    func authorizeUserNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
                UserSettings().notificationsAllowed = true
                
            } else if let error = error {
                print(error.localizedDescription)
                UserSettings().notificationsAllowed = false
            }
        }
    }
    
    func setupMorningNotifications(at chosenTime: Date){
        let content = UNMutableNotificationContent()
        content.title = "☀️ Good Morning \(UserSettings().name)"
        content.body = "Check in with what's flo'ing through your mind since you woke up"
        content.categoryIdentifier = "dailyCheckin"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = Int(chosenTime.hour24)
        dateComponents.minute = Int(chosenTime.minute0x)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "morningCheckin", content: content, trigger: trigger)
        setupCheckinActions() //Add action buttons
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
        print("Adding notif at \(chosenTime.timeShort)")
    }
    func setupEveningNotifications(at chosenTime: Date){
        let content = UNMutableNotificationContent()
        content.title = "🌒 Good Evening \(UserSettings().name)"
        content.body = "Check-in to your thoughts before you wind down for the day."
        content.categoryIdentifier = "dailyCheckin"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = Int(chosenTime.hour24)
        dateComponents.minute = Int(chosenTime.minute0x)
       
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "eveningCheckin", content: content, trigger: trigger)
        setupCheckinActions() //Add action buttons
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
        print("Adding notif at \(chosenTime.timeShort)")
    }
    
    func setupCustomNotifications(at chosenTime: Date){
        let content = UNMutableNotificationContent()
        content.title = "🌖 \(UserSettings().name), Let's check into your thoughts "
        content.body = "Check in with what's flo'ing on your mind right now."
        content.categoryIdentifier = "dailyCheckin"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = Int(chosenTime.hour24)
        dateComponents.minute = Int(chosenTime.minute0x)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "customCheckin", content: content, trigger: trigger)
        setupCheckinActions() //Add action buttons

        // add our notification request
        UNUserNotificationCenter.current().add(request)
        print("Adding notif at \(chosenTime.timeShort)")
    }
    
    func setupRecheckinNotifications(inHours: Int, moodTitle: String){
        let content = UNMutableNotificationContent()
        content.title = "Still feeling \(moodTitle)?"
        content.body = "\(UserSettings().name), Let's go deeper into what's flo'ing through your mind."
        content.categoryIdentifier = "reCheckin"
        content.sound = UNNotificationSound.default
        let intervalSeconds = Double(inHours) * 3600.00
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervalSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "reCheckin", content: content, trigger: trigger)
        setupRecheckinActions(moodTitle) //Add action buttons
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
        print("Scheduling recheckin for \(inHours)")
    }
    
    func removePendingNotifications(_ identifiers: [String]){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        print("Removing notif \(String(describing: identifiers.first))")
    }
    
    func setupCheckinActions() {
        let write = UNNotificationAction(identifier: "write", title: "Today I feel...", options: .foreground)
        let dismiss = UNNotificationAction(identifier: "cancel", title: "Dismiss", options: .destructive)
        let category = UNNotificationCategory(identifier: "dailyCheckin", actions: [write, dismiss], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func setupRecheckinActions(_ moodTitle: String) {
        let writeWithMood = UNNotificationAction(identifier: "writeWithMood", title: "I still feel \(moodTitle)", options: .foreground)
        let write = UNNotificationAction(identifier: "write", title: "Today I feel...", options: .foreground)
        let dismiss = UNNotificationAction(identifier: "cancel", title: "Dismiss", options: .destructive)
        let category = UNNotificationCategory(identifier: "dailyCheckin", actions: [writeWithMood, write, dismiss], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
