//
//  JournalDetailView.swift
//  MindFlo
//
//  Created by Adit Gupta on 30/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import Firebase

struct JournalDetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var pickedMoodEdit: PickedMoodEdit
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    @State private var showEditSheet = false
    @State private var showDeleteAlert = false
    
    var mindFloEntry: MoodJournalEntry
    @Binding var isNavigationBarHidden: Bool
    
    var body: some View {
        Group {
            if mindFloEntry.journalDate != nil  {
                ScrollView(.vertical, showsIndicators: false) {

                        VStack {
                            HStack {
                                //Date is in the navigation bar
                                //Time
                                Text("\(mindFloEntry.journalDate!.weekDayShort), \(mindFloEntry.journalDate!.timeShort.lowercased()) ")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            
                            //Large details card
                            DetailsCard(mindFloEntry: mindFloEntry)
                            
                            VStack(spacing: 24){
                                //Buttons
                                
                                HStack{
                                    Button(action: {
                                        //EDIT button
                                        UISelectionFeedbackGenerator().selectionChanged()
                                        self.setupEditDataFromEntry()
                                        self.showEditSheet.toggle()
                                    }) {
                                        //edit button
                                        Image(systemName: "square.and.pencil")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.black)
                                            .padding(.horizontal)
                                    }
                                    .sheet(isPresented: $showEditSheet){
                                        //Edit content here
                                        EditMoodJournalView(mindFloEntryEdit: self.mindFloEntry)
                                        .environmentObject(self.pickedMoodEdit)
                                        .environment(\.managedObjectContext, self.managedObjectContext)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        //SHARE Button
                                        UISelectionFeedbackGenerator().selectionChanged()
                                        self.setupShareSheet()
                                    }) {
                                    //Share button
                                    Image(systemName: "square.and.arrow.up.on.square")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding()
                                    }
                                    
                                    Spacer()
                                    Button(action: {
                                        //DELETE button alert
                                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                                        self.showDeleteAlert.toggle()
                                        
                                    }) {
                                        Image(systemName: "trash")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.black)
                                            .padding(.horizontal)
                                    }
                                    .actionSheet(isPresented: $showDeleteAlert) {
                                        ActionSheet(
                                            title: Text("Are you sure you want to delete this Mindflo entry?"),
                                            buttons: [.destructive(Text("Yes, Delete"), action: {
                                                UINotificationFeedbackGenerator().notificationOccurred(.error)
                                                
                                                self.managedObjectContext.delete(self.mindFloEntry)
                                                
                                                do {
                                                    try self.managedObjectContext.save()
                                                }catch{
                                                    print(error)
                                                }
                                                //Firebase
                                                Analytics.logEvent("details_deleteAction", parameters: ["source" : "details"])
                                            }), .cancel()]
                                        )
                                    }
                                }
                                
                                
                            }
                            .padding(.top)
                            
                        }
                        .padding(.horizontal)
                        // For readability of buttons at the bottom
                    Spacer().frame(height: 16)
                }
                .navigationBarTitle(Text("\(mindFloEntry.journalDate!.dayMedium) \(mindFloEntry.journalDate!.monthMedium)"))
                .navigationBarHidden(false)
                .onAppear(){
                    self.isNavigationBarHidden = false
                    
                    //Firebase
                    Analytics.logEvent(AnalyticsEventScreenView,
                                       parameters: [AnalyticsParameterScreenName: "Journal Details"])
                }
            } else {
                EmptyView()
            }
        }
        
    }
    func setupShareSheet(){
        let text = "On \(dateFormatter.string(from: mindFloEntry.journalDate!)) I felt \(mindFloEntry.moodEmoji!) \(mindFloEntry.moodTitle!). Sent via @Mindflo"
        //let url = URL(string: "https://aditsgupta.com")
        var image = UIImage(named: "AppIcon")!
        if let imgData = mindFloEntry.journalImage{
            image = UIImage(data: imgData)!
        }
        
        let av = UIActivityViewController(activityItems: [text, image], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        
        //Firebase
        Analytics.logEvent("details_ShareAction", parameters: ["source" : "details"])
    }
    
    func setupEditDataFromEntry(){
        pickedMoodEdit.moodEmoji = mindFloEntry.moodEmoji ?? ""
        pickedMoodEdit.moodTitle = mindFloEntry.moodTitle ?? ""
        pickedMoodEdit.moodColorHexCode = mindFloEntry.moodColorHexCode ?? "eee"
        pickedMoodEdit.journalText = mindFloEntry.journalText ?? ""
        pickedMoodEdit.journalDate = mindFloEntry.journalDate!
        pickedMoodEdit.journalImage = UIImage(data: mindFloEntry.journalImage ?? Data()) ?? UIImage()
        
        //Firebase
        Analytics.logEvent("details_EditAction", parameters: ["source" : "details"])
    }
}

struct DetailsCard: View {
    var mindFloEntry : MoodJournalEntry
    var body: some View {
        VStack(alignment: .leading) {
            //Large card view
            HStack(spacing: 12) {
                Text("\(mindFloEntry.moodEmoji!)")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                
                Text("\(mindFloEntry.moodTitle!)")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 24)
            
            //Body text
            Text("\(mindFloEntry.journalText!)")
                .font(.system(size:20))
                .foregroundColor(Color(.black))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.top, .leading, .trailing])
            
            
            //Photo
            HStack{
                mindFloEntry.journalImage.map { imagedata in
                    
                    Image(uiImage: UIImage(data: imagedata)!).resizable()
                        .renderingMode(.original)
                        .aspectRatio(UIImage(data: imagedata)!.size, contentMode: .fill)
                        .frame(maxHeight: 360, alignment: .center)
                        .cornerRadius(24)
                }
            }
            .padding([.bottom, .leading, .trailing])
            
        }
        .background(
            RoundedRectangle(cornerRadius: 32.0)
                .foregroundColor(Color(hex: mindFloEntry.moodColorHexCode ?? "EEE"))
                .shadow(color: Color.black.opacity(0.10), radius: 0, x: 2, y: 3)
        )
            .background(
                RoundedRectangle(cornerRadius: 32)
                    .offset(x: 2, y: 3)
                    .foregroundColor(Color(hex: mindFloEntry.moodColorHexCode ?? "EEE"))
        )
            .shadow(color: Color(.gray).opacity(0.10), radius: 4, x: 1, y: 2)
            .padding(.top)
    }
    
}


struct JournalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sampleMoodJournalEntry = MoodJournalEntry(context: context)
        sampleMoodJournalEntry.journalText = "This is my loooonng journal entry. You can clearly see I'm pissed at this!Why the hell is this not working!!!This is my loooonng journal entry. You can clearly see I'm pissed at this!Why the hell is this not working!!!"
        sampleMoodJournalEntry.moodTitle = "Frustrated"
        sampleMoodJournalEntry.moodEmoji = "😡"
        sampleMoodJournalEntry.moodColorHexCode = ColorManager.pastelRed.uiColor() .hexString
        sampleMoodJournalEntry.journalDate = Date()
        sampleMoodJournalEntry.journalImage = UIImage(named: "testFlower")!.jpegData(compressionQuality: 0.5)
        
        return JournalDetailView(mindFloEntry: sampleMoodJournalEntry, isNavigationBarHidden: .constant(false))
    }
}
