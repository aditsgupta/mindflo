//
//  SettingsMainView.swift
//  MindFlo
//
//  Created by Adit Gupta on 05/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import Firebase
import StoreKit

struct SettingsMainView: View {
    @Environment(\.openURL) var openURL //to open Safari links
    
    @State private var showTimepickerMorning = false
    @State private var showTimepickerEvening = false
    @State private var showTimepickerCustom = false
    @State private var showProUpgrade = false
    @State private var addUserName = false
    @Binding var userSettings: UserSettings
    @Binding var isNavigationBarHidden: Bool
    
    var body: some View {
        
        ScrollView {
            VStack {
                //Data & privacy
                ZStack(alignment: .bottomLeading){
                    ColorManager.pastelBlue
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading){
                            
                            Text("Data & privacy")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.top, 8)
                            
                            Text("We don’t store any private data or track your personal info.")
                                .font(.system(size: 12))
                                .padding(.top, 8)
                                .foregroundColor(Color.black.opacity(0.6))
                        }
                        .padding([.top, .leading, .bottom], 16)
                        Spacer()
                        Image("privacySettings")
                    }
                }
                
                NavigationLink(destination: AddNameView(userSettings: $userSettings), isActive: $addUserName) {
                    MFListView(title: (userSettings.name.isEmpty ? "Add your name" : userSettings.name), icon: "person.crop.circle")
                }
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    MFListToggleView(title: "App lock", icon: "faceid", toggleState: $userSettings.faceID)
                }
                
                NavigationLink(destination: PrivacyPromiseView()) {
                    MFListView(title: "Our privacy promise", icon: "lock.shield.fill", divider: false)
                }
                
            }
            .buttonStyle(PlainButtonStyle())
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.1), radius: 0, x: 2, y: 2)
            .shadow(color: Color.black.opacity(0.1), radius: 0, x: -1, y: -1)
            .padding([.top,.leading,.trailing])
            
            VStack {
                //Daily checkins
                ZStack(alignment: .bottomLeading){
                    ColorManager.pastelRed
                    //Color.init("pastelRed")
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading){
                            
                            Text("Daily Check-ins")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.top, 8)
                            
                            Text("Gentle reminders to help you commit to logging your mood.")
                                .font(.system(size: 12))
                                .padding(.top, 8)
                                .foregroundColor(Color.black.opacity(0.6))
                        }
                        .padding([.top, .leading, .bottom], 16)
                        Spacer()
                        Image("calendarSettings")
                    }
                }
                
                if userSettings.notificationsAllowed {
                    //Notifications are allowed
                    Button(action: {
                        //Show ☀️ time picker sheet
                        if !self.userSettings.morningCheckin{
                            self.showTimepickerMorning.toggle()
                        }
                        
                    }) {
                        MFListToggleView(title: "Mornings at \(userSettings.morningCheckinTime.timeShort.lowercased())", icon: "sun.min.fill", toggleState: $userSettings.morningCheckin)
                    }
                    .sheet(height: SheetHeight.points(360), isPresented: $showTimepickerMorning) {
                        MFTimePicker(pickedTime: self.$userSettings.morningCheckinTime, showView: self.$showTimepickerMorning)
                    }
                    
                    Button(action: {
                        //Show 🌙 time picker sheet
                        if !self.userSettings.eveningCheckin{
                            self.showTimepickerEvening.toggle()
                        }
                        
                    }) {
                        MFListToggleView(title: "Evenings at \(userSettings.eveningCheckinTime.timeShort.lowercased())", icon: "moon.fill", toggleState: $userSettings.eveningCheckin)
                    }
                    .sheet(height: SheetHeight.points(360), isPresented: $showTimepickerEvening) {
                        MFTimePicker(pickedTime: self.$userSettings.eveningCheckinTime, showView: self.$showTimepickerEvening)
                            .environmentObject(userSettings)
                    }
                    
                    Button(action: {
                        //Show ⏱custom time picker sheet
                        self.userSettings.customCheckinSetup = true
                        
                        self.showTimepickerCustom.toggle()
                    }) {
                        if userSettings.customCheckinSetup {
                            MFListToggleView(title: "Everyday at \(userSettings.customCheckinTime.timeShort.lowercased())", icon: "clock.fill", toggleState: $userSettings.customCheckin, divider: false)
                        }
                        else{
                            MFListView(title: "Choose a time", icon: "plus.circle.fill", divider: false)
                        }
                    }
                    .sheet(height: SheetHeight.points(400), isPresented: $showTimepickerCustom) {
                        VStack {
                            Button(action: {
                                //Reset the toggleview
                                self.userSettings.customCheckinSetup = false
                                //dismiss sheet
                                self.showTimepickerCustom.toggle()
                                
                            }) {
                                Text("Remove")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding()
                            
                            MFTimePicker(pickedTime: self.$userSettings.customCheckinTime, showView: self.$showTimepickerCustom)
                        }
                        .background(Color.white)
                    }
                    //
                } else {
                    //Notifications not allowed
                    Button(action: {
                        NotificationsHelper().authorizeUserNotification()
                    }) {
                        MFListView(title: "Allow notifications", icon: "alarm.fill", divider: false)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.1), radius: 0, x: 3, y: 3)
            .shadow(color: Color.black.opacity(0.1), radius: 0, x: -1, y: 1)
            .padding([.top,.leading,.trailing])
            
            VStack {
                //About
                ZStack(alignment: .bottomLeading){
                    ColorManager.pastelYellow
                    //Color.init("pastelYellow")
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading){
                            
                            Text("About")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.top, 8)
                            
                            Text("Crafted with love from India 🇮🇳.")
                                .font(.system(size: 12))
                                .padding(.top, 8)
                                .foregroundColor(Color.black.opacity(0.6))
                        }
                        .padding([.top, .leading, .bottom], 16)
                        Spacer()
                        Image("aboutSettings")
                    }
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    MFListView(title: "Share Mindflo", icon: "square.and.arrow.up.fill")
                }
                
                Button(action: {
                    let urlString = "mailto:aditsgupta@gmail.com?subject=Minflo feedback".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                    openURL(URL(string: urlString!)!)
                }) {
                    MFListView(title: "Send feedback", icon: "envelope.open.fill")
                }
                
                Button(action: {
                    let urlString = "https://twitter.com/intent/tweet?text=Hey @aditsgupta".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                    openURL(URL(string: urlString!)!)
                }) {
                    MFListView(title: "Tweet to me", icon: "paperplane.fill")
                }
                
                Button(action: {
                    //Update usersetting for rate app
                    userSettings.rateMindfloTaps += 1
                    
                    if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene) }
                }) {
                    MFListView(title: "Rate on App Store", icon: "star.circle.fill", divider: false)
                }
                
                /*
                 For Pro Upgrade stuff
                Button(action: {
                    self.showProUpgrade.toggle()
                }) {
                    MFListView(title: "Upgrade to Pro", icon: "star.circle.fill", divider: false)
                }
                .sheet(isPresented: $showProUpgrade, content: {
                    MFProUpgrade()
                })
                 */
                
                //NavigationLink("testing", destination: testinng())
            }
            .buttonStyle(PlainButtonStyle())
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.1), radius: 0, x: 3, y: 3)
            .shadow(color: Color.black.opacity(0.1), radius: 0, x: -1, y: 1)
            .padding([.top,.leading,.trailing])
            
        }
        //.background(ColorManager.bgGrey.edgesIgnoringSafeArea(.all))
        .font(.system(size: 16))
        .navigationBarTitle("Preferences")
        .navigationBarHidden(false)
        .onAppear(){
            self.isNavigationBarHidden = false

            //Firebase
            Analytics.logEvent(AnalyticsEventScreenView,
                               parameters: [AnalyticsParameterScreenName: "Settings",
                                            "App lock enabled" : self.userSettings.faceID])
        }
        
    }
}



struct SettingsMainView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMainView(userSettings: .constant(UserSettings()), isNavigationBarHidden: .constant(false))
    }
}
