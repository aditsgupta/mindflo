//
//  UserSettings.swift
//  MindFlo
//
//  Created by Adit Gupta on 05/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
import Combine

public class UserSettings: ObservableObject {
    
    @Published var name: String {
        didSet{
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    
    @Published var faceID: Bool {
        didSet{
            UserDefaults.standard.set(faceID, forKey: "faceID")
            if !faceID {
                NotificationsHelper().authorizeUserNotification()
            }
        }
    }
    
    //Checkin settings

    @Published var morningCheckin: Bool {
        didSet{
            UserDefaults.standard.set(morningCheckin, forKey: "morningCheckin")
            
            //remove previous ☀️ notification always
            NotificationsHelper().removePendingNotifications(["morningCheckin"])
            
            if morningCheckin{
                //add new ☀️ notification if true
                NotificationsHelper().setupMorningNotifications(at: morningCheckinTime)
            }
        }
    }
    @Published var morningCheckinTime: Date {
        didSet{
            UserDefaults.standard.set(morningCheckinTime, forKey: "morningCheckinTime")
            //remove previous ☀️ notification always
            NotificationsHelper().removePendingNotifications(["morningCheckin"])
            
            if morningCheckin{
                //add new ☀️ notification if true
                NotificationsHelper().setupMorningNotifications(at: morningCheckinTime)
            }
        }
    }
    

    @Published var eveningCheckin: Bool {
        didSet{
            UserDefaults.standard.set(eveningCheckin, forKey: "eveningCheckin")
            //remove previous 🌙 notification always
            NotificationsHelper().removePendingNotifications(["eveningCheckin"])
            
            if eveningCheckin{
                //add new 🌙 notification if true
                NotificationsHelper().setupEveningNotifications(at: eveningCheckinTime)
            }
        }
    }
    
    @Published var eveningCheckinTime: Date {
        didSet{
            UserDefaults.standard.set(eveningCheckinTime, forKey: "eveningCheckinTime")
            //remove previous 🌙 notification always
            NotificationsHelper().removePendingNotifications(["eveningCheckin"])
            
            if eveningCheckin{
                //add new 🌙 notification if true
                NotificationsHelper().setupEveningNotifications(at: eveningCheckinTime)
            }
        }
    }
    
    @Published var customCheckinSetup: Bool {
        didSet{
            UserDefaults.standard.set(customCheckinSetup, forKey: "customCheckinSetup")
            
        }
    }
    
    @Published var customCheckin: Bool {
        didSet{
            UserDefaults.standard.set(customCheckin, forKey: "customCheckin")
            
            //remove previous ⏱ notification always
            NotificationsHelper().removePendingNotifications(["customCheckin"])
            
            if customCheckin{
                //add new ⏱ notification if true
                NotificationsHelper().setupCustomNotifications(at: customCheckinTime)
            }
        }
    }
    
    @Published var customCheckinTime: Date {
        didSet{
            UserDefaults.standard.set(customCheckinTime, forKey: "customCheckinTime")
            //remove previous ⏱ notification always
            NotificationsHelper().removePendingNotifications(["customCheckin"])
            
            if customCheckin{
                //add new ⏱ notification if true
                NotificationsHelper().setupCustomNotifications(at: customCheckinTime)
            }
        }
    }
    
    //User Lifecycle settings
    @Published var mfdayZero: Date {
        //Date of onboarding the user
        didSet{
            UserDefaults.standard.set(mfdayZero, forKey: "mfdayZero")
        }
    }
    
    @Published var mfJournalPosts: Int {
        //
        didSet{
            UserDefaults.standard.set(mfJournalPosts, forKey: "mfJournalPosts")
        }
    }
    
    @Published var mfJournalDays: Int {
        //
        didSet{
            UserDefaults.standard.set(mfJournalDays, forKey: "mfJournalDays")
        }
    }
    // fin User Lifecycle settings
    
    init() {
        //Personal settings default
        self.name = UserDefaults.standard.object(forKey: "name") as? String ?? ""
        self.faceID = UserDefaults.standard.object(forKey: "faceID") as? Bool ?? false
        
        //Checkin settings default
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm, d MMM y"
        let morningTimeDefault = dateformatter.date(from: "08:00, 01 Jan 2020")
        let eveningTimeDefault = dateformatter.date(from: "20:00, 01 Jan 2020")
        let customTimeDefault = dateformatter.date(from: "14:00, 01 Jan 2020")
        
        self.morningCheckin = UserDefaults.standard.object(forKey: "morningCheckin") as? Bool ?? false
        self.morningCheckinTime = UserDefaults.standard.object(forKey: "morningCheckinTime") as? Date ?? morningTimeDefault!
        
        self.eveningCheckin = UserDefaults.standard.object(forKey: "eveningCheckin") as? Bool ?? false
        self.eveningCheckinTime = UserDefaults.standard.object(forKey: "eveningCheckinTime") as? Date ?? eveningTimeDefault!
        
        self.customCheckinSetup = UserDefaults.standard.object(forKey: "customCheckinSetup") as? Bool ?? false
        self.customCheckin = UserDefaults.standard.object(forKey: "customCheckin") as? Bool ?? false
        self.customCheckinTime = UserDefaults.standard.object(forKey: "customCheckinTime") as? Date ?? customTimeDefault!
        
        //LifecycleSettings
        self.mfdayZero = UserDefaults.standard.object(forKey: "mfdayZero") as? Date ?? Date()
        self.mfJournalPosts = UserDefaults.standard.object(forKey: "mfJournalPosts") as? Int ?? 0
        self.mfJournalDays = UserDefaults.standard.object(forKey: "mfJournalDays") as? Int ?? 0
        
    }
}
