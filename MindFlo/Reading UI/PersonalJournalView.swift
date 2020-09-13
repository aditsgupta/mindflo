//
//  PersonalJournalView.swift
//  MindFlo
//
//  Created by Adit Gupta on 30/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct PersonalJournalView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: MoodJournalEntry.entity(), sortDescriptors: [NSSortDescriptor(key: "journalDate", ascending: false)])
    var MoodJournalItems:FetchedResults<MoodJournalEntry>
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
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
    @State private var showSettingsSheet = false
    
    init(userSettings: Binding<UserSettings>, isNavigationBarHidden: Binding<Bool>) {
        //init the Binding
        self._isNavigationBarHidden = isNavigationBarHidden
        self._userSettings = userSettings
        
        UITableView.appearance().separatorStyle = .none // Remove separators
        //UITableView.appearance().tableFooterView = UIView() //Remove empty bottom list items
        UITableView.appearance().backgroundColor = .clear //Remove BG colors
        UITableViewCell.appearance().backgroundColor = .clear // cell background
        UITableViewCell.appearance().selectionStyle = .none // Remove cell tap color
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear //Removes Section header color BG
        //UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude)) //Removes Height of topsection?
        
        //NAVIGATION VIEW OVERRIDES
        //        let coloredNavAppearance = UINavigationBarAppearance()
        //        //coloredNavAppearance.configureWithOpaqueBackground()
        //        //coloredNavAppearance.backgroundColor = .white
        //        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        //        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        //
        //        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        //        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
        
    }
    
    var body: some View {
        NavigationView {
            List{
                Section() {
                    HStack{
                        ZStack {
                            //Setting button
                            NavigationLink(destination: SettingsMainView(userSettings: userSettings, isNavigationBarHidden: $isNavigationBarHidden), isActive: $showSettingsSheet) {
                                EmptyView()
                            }
                            .frame(width: 32)
                            .onTapGesture {
                                UIImpactFeedbackGenerator().impactOccurred(intensity: 0.5)
                            }
                            Image("mindfloProfile")
                        }
                        Spacer()
                        Image("mindfloTypeLogo")
                        Spacer()
                        Image("mindfloProfile").opacity(0.0)
                    }
                    .padding(.top, 8)
                }
                Section() {
                    QuoteView(mindfloDay: groupedByDate(MoodJournalItems).count)
                }
                
                
                ForEach(groupedByDate(MoodJournalItems), id: \.self) { moodJournalEntriesGroup in
                    JournalRowView(mindFloEntries: moodJournalEntriesGroup, isNavigationBarHidden: self.$isNavigationBarHidden)
                    //.listRowInsets(EdgeInsets(top: 0, leading: 16.0, bottom: 16, trailing: 16))
                }
                Section(){
                    Spacer().frame(height: 64)
                    //end of list spacing for readabbility
                }
                
            }
            .listStyle(PlainListStyle())
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
            self.userSettings.mfJournalDays = self.groupedByDate(self.MoodJournalItems).count
            
            print("Days are \(self.userSettings.mfJournalDays) && Posts are \(self.userSettings.mfJournalPosts)")
        }
    }
}

struct PersonalJournalView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return PersonalJournalView(userSettings: .constant(UserSettings()), isNavigationBarHidden: .constant(true)).environment(\.managedObjectContext, context)
    }
}
