//
//  ContentView.swift
//  MindFlo
//
//  Created by Adit Gupta on 06/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var isNavigationBarHidden = true
    //Source of truth values
    @State var showMoodSheet = false
    @State var authenticatedUser = false
    @State var userSettings = UserSettings()
    
    let chooseMoodPublisher = NotificationCenter.default.publisher(for: NSNotification.Name("chooseMood"))
    
    var body: some View {
        ZStack(alignment: .top) {
            PersonalJournalView(userSettings: $userSettings, isNavigationBarHidden: $isNavigationBarHidden)
            
            if isNavigationBarHidden {
                CircularPrimaryButton(showMoodSheet: $showMoodSheet)
            }
            
            if !authenticatedUser && userSettings.faceID {
                AuthenticationBlurView(authenticatedUser: $authenticatedUser, userSettings: $userSettings)
            }
        }
        .onReceive(chooseMoodPublisher) { (_) in
            self.showMoodSheet = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            if self.userSettings.faceID{
                self.authenticatedUser = false
            }
            else{
                self.authenticatedUser = true
            }
            print(" Moving to background, add the faceid!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return Group {
            ContentView()
                .environment(\.managedObjectContext, context)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
            ContentView()
                .environment(\.managedObjectContext, context)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
                .previewDisplayName("iPhone 11 Pro")
        }
    }
}

