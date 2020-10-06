//
//  UserSettings.swift
//  MindFlo
//
//  Created by Adit Gupta on 05/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
import Combine
import Firebase

public class UserSettings: ObservableObject {
    
    @Published var name: String {
        didSet{
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    
    @Published var avatarID: Int {
        didSet{
            UserDefaults.standard.set(avatarID, forKey: "avatarID")
        }
    }
    
    @Published var faceID: Bool {
        didSet{
            UserDefaults.standard.set(faceID, forKey: "faceID")
        }
    }
    
    //Checkin settings
    
    @Published var notificationsAllowed: Bool {
        didSet{
            UserDefaults.standard.set(notificationsAllowed, forKey: "notificationsAllowed") 
        }
    }

    @Published var morningCheckin: Bool {
        didSet{
            UserDefaults.standard.set(morningCheckin, forKey: "morningCheckin")
            
            //remove previous ☀️ notification always
            NotificationsHelper().removePendingNotifications(["morningCheckin"])
            
            if morningCheckin{
                NotificationsHelper().authorizeUserNotification()
                //add new ☀️ notification if true
                NotificationsHelper().setupMorningNotifications(at: morningCheckinTime)
            }
            //Update UserProperty in FireBase analytics
            updateMFCheckinsUserProperty()
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
                NotificationsHelper().authorizeUserNotification()
                //add new 🌙 notification if true
                NotificationsHelper().setupEveningNotifications(at: eveningCheckinTime)
            }
             //Update UserProperty in FireBase analytics
            updateMFCheckinsUserProperty()
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
                NotificationsHelper().authorizeUserNotification()
                //add new ⏱ notification if true
                NotificationsHelper().setupCustomNotifications(at: customCheckinTime)
            }
             //Update UserProperty in FireBase analytics
            updateMFCheckinsUserProperty()
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
        //number of posts made by the user
        didSet{
            UserDefaults.standard.set(mfJournalPosts, forKey: "mfJournalPosts")
            
            //Send updated User property to Firebase
            updateMFPostsUserProperty(posts: mfJournalPosts)
        }
    }
    
    @Published var mfJournalDays: Int {
        //number of Journaling days
        didSet{
            UserDefaults.standard.set(mfJournalDays, forKey: "mfJournalDays")
        }
    }
    
    @Published var rateMindfloTaps: Int {
        didSet{
            UserDefaults.standard.set(rateMindfloTaps, forKey: "rateMindfloTaps")
        }
    }
    // fin User Lifecycle settings
    
    init() {
        //Personal settings default
        self.name = UserDefaults.standard.object(forKey: "name") as? String ?? ""
        self.avatarID = UserDefaults.standard.object(forKey: "avatarID") as? Int ?? 2
        self.faceID = UserDefaults.standard.object(forKey: "faceID") as? Bool ?? false
        
        //Checkin settings default
        self.notificationsAllowed = UserDefaults.standard.object(forKey: "notificationsAllowed") as? Bool ?? false
        
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
        self.rateMindfloTaps = UserDefaults.standard.object(forKey: "rateMindfloTaps") as? Int ?? 0
    }
    
    func updateMFPostsUserProperty(posts: Int){
        var propertyString = ""
        
        switch posts {
        case 0..<3:
            propertyString = "< 3 posts"
        case 3..<10:
            propertyString = "3-10 posts"
        case 11..<20:
            propertyString = "11-20 posts"
        case 20..<50:
            propertyString = "20-50 posts"
        case 50..<100:
            propertyString = "50-100 posts"
        default:
            propertyString = "> 100 posts"
        }
        //Set User properties Firebase
        Analytics.setUserProperty(propertyString, forName: "MFPosts_Lifecycle")
    }
    
    func updateMFCheckinsUserProperty(){
        let propertyString = "\(morningCheckin ? "Morning" : "") \(eveningCheckin ? "Evening" : "") \(customCheckin ? "Custom": "") \(!morningCheckin && !eveningCheckin && !customCheckin ? "none" : "")"
        //Set User properties Firebase
        Analytics.setUserProperty(propertyString, forName: "MFCheckins_active")
        
    }
}
