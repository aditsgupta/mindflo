//
//  PersonalJournalView.swift
//  MindFlo
//
//  Created by Adit Gupta on 30/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
// ONLY for iOS13

import SwiftUI
import Firebase

struct PersonalJournalView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: MoodJournalEntry.entity(), sortDescriptors: [NSSortDescriptor(key: "journalDate", ascending: false)])
    var MoodJournalItems:FetchedResults<MoodJournalEntry>
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    let chooseMoodPublisher = NotificationCenter.default.publisher(for: NSNotification.Name("chooseMood"))
    
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
    
    init(userSettings: Binding<UserSettings>, isNavigationBarHidden: Binding<Bool>) {
        //init the Binding
        self._isNavigationBarHidden = isNavigationBarHidden
        self._userSettings = userSettings
        
        UITableView.appearance().separatorStyle = .none // Remove separators
        UITableView.appearance().tableFooterView = UIView() //Remove empty bottom list items
        UITableView.appearance().backgroundColor = .clear //Remove BG colors
        UITableViewCell.appearance().backgroundColor = .clear // cell background
        UITableViewCell.appearance().selectionStyle = .none // Remove cell tap color
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear //Removes Section header color BG
        UITableView.appearance().backgroundView?.backgroundColor = UIColor.clear
    }
    
    var body: some View {
        NavigationView {
            List{
                Section() {
                    MindfloHeaderView(userSettings: $userSettings, isNavigationBarHidden: $isNavigationBarHidden, showSettingsView: $showSettingsView)
                }
                
                Section() {
                    QuoteView(mindfloDay: groupedByDate(MoodJournalItems).count)
                }
                
                ForEach(groupedByDate(MoodJournalItems), id: \.self) { moodJournalEntriesGroup in
                    
                    Section(header:
                        
                        VStack(alignment: .leading, spacing: 0.0){
                            //Date component
                            Text("\(moodJournalEntriesGroup[0].journalDate!.monthMedium)")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            Text("\(moodJournalEntriesGroup[0].journalDate!.dayMedium)")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                            
                        }
                        .padding(.top, 4)
                        .frame(height: 36)
                        .listRowInsets(EdgeInsets(top: 32, leading: 16, bottom: -32, trailing: 8))

                        //end of section header
                    ){
                        
                        JournalRowView(mindFloEntries: moodJournalEntriesGroup, isNavigationBarHidden: self.$isNavigationBarHidden)
                    }
                }

                Section(){
                    Spacer().frame(height: 72)
                    //end of list spacing for readability
                }
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(self.isNavigationBarHidden)
            .onAppear(){
                self.isNavigationBarHidden = true
            }
        }
        .onAppear(){
            // Update number of posts
            self.userSettings.mfJournalPosts = self.MoodJournalItems.count
            //Update number of Days
            self.userSettings.mfJournalDays =  self.groupedByDate(self.MoodJournalItems).count
            
            //Firebase
            Analytics.logEvent("home_Visit", parameters: [
                "MFJ_posts" : self.userSettings.mfJournalPosts,
                "MFJ_days" : self.userSettings.mfJournalDays
            ])
        }
        
        .onReceive(chooseMoodPublisher) { (_) in
            //Remove all other views so that CHooseMoodsheet from notifications can be launched
            self.showSettingsView = false
            self.showPrivacySheet = false
        }
    }
}

struct PersonalJournalView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return PersonalJournalView(userSettings: .constant(UserSettings()), isNavigationBarHidden: .constant(true)).environment(\.managedObjectContext, context)
    }
}
