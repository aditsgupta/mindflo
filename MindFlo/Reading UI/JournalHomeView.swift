//
//  JournalHomeView.swift
//  MindFlo
//
//  Created by Adit Gupta on 17/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import Firebase

struct JournalHomeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: MoodJournalEntry.entity(), sortDescriptors: [NSSortDescriptor(key: "journalDate", ascending: false)])
    var MoodJournalItems:FetchedResults<MoodJournalEntry>
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    let chooseMoodPublisher = NotificationCenter.default.publisher(for: NSNotification.Name("chooseMood"))
    let saveMFJournalPublisher = NotificationCenter.default.publisher(for: NSNotification.Name("saveMFJournal"))
    
    //Group & sort the results by date
    func groupedByDate(_ result : FetchedResults<MoodJournalEntry>) -> [[MoodJournalEntry]]{
        return  Dictionary(grouping: result){ (element : MoodJournalEntry)  in
            dateFormatter.string(from: element.journalDate!)
        }.values.sorted() { $0[0].journalDate! > $1[0].journalDate! }
    }
    
    //From the main content view source of truth
    @Binding var userSettings: UserSettings
    @Binding var isNavigationBarHidden: Bool
    //Showing sheets
    @State private var showSettingsView = false
    @State private var showPrivacySheet = false
    @State private var showLifecycleSheet = false
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                Section() {
                    MindfloHeaderView(userSettings: $userSettings, isNavigationBarHidden: $isNavigationBarHidden, showSettingsView: $showSettingsView)
                        .padding(.horizontal)
                }
                
                Section() {
                    QuoteView(mindfloDay: groupedByDate(MoodJournalItems).count)
                    
                }
                if MoodJournalItems.isEmpty {
                    Section(){
                        FTUEView(userSettings: $userSettings)
                    }
                }
                
                LazyVStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16, pinnedViews: [.sectionHeaders], content: {
                    
                    ForEach(groupedByDate(MoodJournalItems), id: \.self) { moodJournalEntriesGroup in
                        Section(header:
                                    HStack {
                                        VStack(alignment: .leading, spacing: 0.0){
                                            //Date component
                                            Text("\(moodJournalEntriesGroup[0].journalDate!.monthMedium)")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                            
                                            Text("\(moodJournalEntriesGroup[0].journalDate!.dayMedium)")
                                                .font(.system(size: 24))
                                                .fontWeight(.semibold)
                                        }
                                        .padding(.top, 16)
                                        .frame(height: 1)
                                        Spacer()
                                    }
                                    .offset(x: 16, y: 32)
                                    .padding(.bottom, 16)
                                //.background(Color.red)
                        ){
                            JournalRowView(mindFloEntries: moodJournalEntriesGroup, isNavigationBarHidden: self.$isNavigationBarHidden)
                                .padding(.horizontal)
                        }
                    }
                    
                    Section(){
                        Spacer().frame(height: 72)
                        //end of list spacing for readability
                    }
                })
                .sheet(isPresented: self.$showLifecycleSheet, content: {
                    LifecycleView()
                })
            }
            .navigationBarTitle("")
            .navigationBarHidden(self.isNavigationBarHidden)
            .onAppear(){
                self.isNavigationBarHidden = true
            }
        }
        .onAppear(){
            let mfJournalPosts = self.MoodJournalItems.count
            let mfJournalDays = self.groupedByDate(self.MoodJournalItems).count
            
            // Update number of posts & days
            self.userSettings.mfJournalPosts = mfJournalPosts
            self.userSettings.mfJournalDays = mfJournalDays
            
            
            //Firebase
            Analytics.logEvent(AnalyticsEventScreenView,
                               parameters: [AnalyticsParameterScreenName: "Journal Home",
                                            "MFJ_posts" : mfJournalPosts,
                                            "MFJ_days" : mfJournalDays])
        }
        
        .onReceive(chooseMoodPublisher) { _ in
            //Remove all other views so that CHooseMoodsheet from notifications can be launched
            self.showSettingsView = false
            self.showPrivacySheet = false
        }
        .onReceive(saveMFJournalPublisher) { _ in
            //Trigger lifecycle event based on this logic
            let mfJournalPosts = self.MoodJournalItems.count
            let mfJournalDays = self.groupedByDate(self.MoodJournalItems).count
            
            // Update number of posts & days
            self.userSettings.mfJournalPosts = mfJournalPosts
            self.userSettings.mfJournalDays = mfJournalDays
            
            //Lifecycle sheet logic
            switch mfJournalPosts {
            case 1:
                //First time
                self.showLifecycleSheet.toggle()
                print("first time!")
            case let num where mfJournalPosts % 5 == 0:
                //Every fifth time
                self.showLifecycleSheet.toggle()
                print("\(num) times")
                
            default:
                print("Nothing to do \(mfJournalPosts)")
            }
            
            
        }
        
    }
}

struct JournalHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return JournalHomeView(userSettings: .constant(UserSettings()), isNavigationBarHidden: .constant(true)).environment(\.managedObjectContext, context)
    }
}
