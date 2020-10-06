//
//  WriteMoodJournalView.swift
//  MindFlo
//
//  Created by Adit Gupta on 06/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

struct WriteMoodJournalView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //Picked Values
    @EnvironmentObject var pickedMood: PickedMood
    
    //Show alerts and sheets
    @State private var showGalleryPicker: Bool = false
    @State private var showCameraPicker: Bool = false
    @State private var showJournalDeleteAlert: Bool = false
    @State private var showImageDeleteAlert: Bool = false
    @State private var showColorPicker: Bool = false
    @State private var recheckinActive: Bool = false
    @State private var showRecheckinTimePicker: Bool = false
    
    @State var txt = ""
    
    
    //Formatter -----> Add from Helper
    static let dateFormat: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        return dateformatter
    }()
    
    
    var body: some View {
        ZStack(alignment: .top) {
            pickedMood.pmColor
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 16) {
                HStack{
                    //Dragbar
                    Rectangle()
                        .frame(width: 36, height: 4, alignment: .center)
                        .cornerRadius(4)
                        .foregroundColor(Color.black.opacity(0.3))
                        .padding(.top, 8)

                }
                HStack {
                    // Mood emoji + title
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        VStack {
                            HStack(alignment: .center, spacing: 16) {
                                //emoji
                                Text("\(pickedMood.pmEmoji)")
                                    .font(.system(size: 40))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                VStack(alignment: .leading) {
                                    //Mood title + Date
                                    Text("\(pickedMood.pmTitle)")
                                    .font(.system(size: 24))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black.opacity(0.8))

                                    Text("\(pickedMood.pmJournalDate, formatter: Self.dateFormat)")
                                     .font(.system(size: 12))
                                        .foregroundColor(Color.black.opacity(0.5))
                                }
                                
                            }
                            
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        self.dismissKeyboard()
                        //self.recheckinActive.toggle()
                        self.showRecheckinTimePicker.toggle()
                        
                    }) {
                        if recheckinActive {
                            Image(systemName: "stopwatch.fill")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(.black)
                                .opacity(0.50)
                                .padding(.all, 8)
                        } else {
                            Image(systemName: "stopwatch")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(.black)
                                .opacity(0.30)
                                .padding(.all, 8)
                        }
                    }
                    .actionSheet(isPresented: $showRecheckinTimePicker) {
                        ActionSheet(
                            title: Text("Checkin on this mood again in..."),
                            buttons: [
                                .default(Text("2 hours")) {
                                    self.pickedMood.recheckInHours = 2
                                    self.recheckinActive = true
                                    },
                                
                                .default(Text("4 hours")) {
                                    self.pickedMood.recheckInHours = 4
                                    self.recheckinActive = true
                                },
                                
                                .default(Text("8 hours")) {
                                    self.pickedMood.recheckInHours = 8
                                    self.recheckinActive = true
                                },
                                
                                .destructive(Text("Don't checkin again"),
                                    action: {
                                        self.recheckinActive = false
                                        self.pickedMood.recheckInHours = 0
                                    }),
                                .cancel()]
                        )
                    }
                    
                    Spacer().frame(width: 8)
                    
                    Button(action: {
                        //Journal primary save action
                        if self.pickedMood.pmJournalTextCount > 5 {
                            //Sucess
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            self.saveMoodJournal()
                            
                        }
                        else{
                            //Do nothing
                            UINotificationFeedbackGenerator().notificationOccurred(.error)
                        }
                        
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.black)
                            .opacity(pickedMood.pmJournalTextCount > 5 ? 1.0 : 0.30)
                            .padding(.all, 8)
                    }
                .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)
  
                //Divider
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(Color.black.opacity(0.10))
                    .padding(.leading, 16)
                
                
                VStack (alignment: .leading) {
                    HStack{
                        insertHintText()
                        .font(.system(size: 18))
                        .foregroundColor(Color.black.opacity(0.6))
                        .padding(.leading, 4)
                        .transition(.slide)
                        
                        Spacer()
                    }
                    .frame(height: 24)
                    .clipped()
                    
                    AutoFocusTextInputView(text: $pickedMood.pmJournalText, isFirstResponder: true)
                        
                }
                .padding(.horizontal, 16)

                
                
                //Bottom Toolbar
                HStack(alignment: .bottom, spacing: 16) {
                    if pickedMood.pmJournalImage == UIImage() {
                        Button(action: {
                            self.dismissKeyboard()
                            //Take a picture
                            self.showCameraPicker.toggle()
                            

                        }) {
                            Image(systemName: "camera")
                                .font(.system(size: 20.0, weight: .bold))
                                .foregroundColor(.black)
                                .opacity(0.9)
                                .padding(.horizontal)
                        }
                        .sheet(isPresented: $showCameraPicker) {
                            ZStack {
                                Color.black.edgesIgnoringSafeArea(.all)
                                CameraImagePicker(selectedImage: self.$pickedMood.pmJournalImage)
                                    .edgesIgnoringSafeArea(.all)
                            }
                        }
                        
                        
                        
                        Button(action: {
                            self.dismissKeyboard()
                            // Choose from gallery
                            self.showGalleryPicker.toggle()

                        }) {
                            Image(systemName: "photo")
                                .font(.system(size: 20.0, weight: .bold))
                                .foregroundColor(.black)
                                .opacity(0.9)
                                .padding(.horizontal)
                        }
                        .sheet(isPresented: $showGalleryPicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$pickedMood.pmJournalImage)
                        }
                    }
                    else {
                        //show PickedImage preview with remove option
                        Button(action: {
                            self.dismissKeyboard()
                            //Remove Image alert
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            self.showImageDeleteAlert.toggle()
                        }) {
                            ZStack(alignment: .topTrailing) {
                                
                                Image(uiImage: pickedMood.pmJournalImage).resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(pickedMood.pmJournalImage.size, contentMode: .fill)
                                    .frame(width: 108, height: 108, alignment: .center)
                                    .cornerRadius(16.0)
                                    //.padding(.horizontal)
                                
                                Image(systemName: "xmark.circle")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color.white.opacity(1))
                                    .frame(width: 20, height: 20)
                                    .padding([.top, .trailing], 4)
                                    .shadow(radius: 1)
                            }
                        }
                        .actionSheet(isPresented: $showImageDeleteAlert) {
                            ActionSheet(
                                title: Text("Remove this photo?"),
                                buttons: [.destructive(Text("Delete"),
                                action: {
                                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                                    self.pickedMood.pmJournalImage = UIImage()
                                        }), .cancel()]
                            )
                        }
                    }
                    Button(action: {
                        self.dismissKeyboard()
                        // Show Color picker
                        self.showColorPicker.toggle()
                    }) {
                        Image(systemName: "square.lefthalf.fill")
                            .font(.system(size: 20.0, weight: .bold))
                            .foregroundColor(.black)
                            .opacity(0.9)
                            .padding(.horizontal)
                    }
                    .sheet(height: SheetHeight.points(300), isPresented: self.$showColorPicker, content: {
                        ColorPickerGridView(showColorPickerGrid: self.$showColorPicker, fromView: "WriteMoodJournalView")
                            .environmentObject(self.pickedMood)
                    })
                    
                    Spacer()
                    Button(action: {
                        self.dismissKeyboard()
                        //Discard & clear Journal entry
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        self.showJournalDeleteAlert.toggle()
                    }) {
                        Image(systemName: "trash")
                            .font(.system(size: 20.0, weight: .bold))
                            .foregroundColor(.black)
                            .opacity(0.9)
                        .padding(.horizontal)
                    }
                    .actionSheet(isPresented: $showJournalDeleteAlert) {
                        ActionSheet(
                            title: Text("Are you sure you want to discard?"),
                            message: Text("Or you can pick this up later."),
                            buttons: [.destructive(Text("Yes, Discard"), action: {
                                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                                    self.pickedMood.pmJournalImage = UIImage()
                                    self.pickedMood.resetPickedMood()
                                    self.dismissMoodSheet()
                                }), .cancel()]
                        )
                    }
                }
                .padding([.horizontal, .top], 8)
                .padding(.bottom, 16)
                
            }
        }
    }
    
    func insertHintText() -> AnyView{
        switch self.pickedMood.pmJournalTextCount {
        case 0...20:
            return AnyView(Text("I felt this way because…"))
        case 21...50:
            return AnyView(Text("What triggered these thoughts?"))
        case 51...80:
            return AnyView(Text("This is a safe space. Write freely."))
        default:
            return AnyView(Text("I felt this way because…"))
        }
    }
    
    func addRecheckinNotification(inHours: Int){
        NotificationsHelper().setupRecheckinNotifications(inHours: inHours, moodTitle: "\(pickedMood.pmEmoji) \(pickedMood.pmTitle)")
    }
    
    func saveMoodJournal(){
        //create a new entry for CD
        let moodJournalEntry = MoodJournalEntry(context: self.managedObjectContext)
        moodJournalEntry.id = UUID()
        moodJournalEntry.journalDate = pickedMood.pmJournalDate
        moodJournalEntry.moodEmoji = pickedMood.pmEmoji
        moodJournalEntry.moodTitle = pickedMood.pmTitle
        moodJournalEntry.journalText = pickedMood.pmJournalText
        moodJournalEntry.moodColorHexCode = pickedMood.pmColor.uiColor().hexString
        
        if(pickedMood.pmJournalImage != UIImage()){
            moodJournalEntry.journalImage = pickedMood.pmJournalImage.jpegData(compressionQuality: 0.80)
        }
        else{
            moodJournalEntry.journalImage = nil
        }
        
        //Save the mood
        do {
            try self.managedObjectContext.save()
        }
        catch{
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        if recheckinActive {
            addRecheckinNotification(inHours: pickedMood.recheckInHours)
        }
        //Post notification for Lifecycle event trigger
        NotificationCenter.default.post(name: NSNotification.Name("saveMFJournal"), object: nil)
        
        //Firebase
        Analytics.logEvent("writeMF_SaveButton", parameters: [
            "MFJ_chars" : pickedMood.pmJournalTextCount as Int,
            "MFJ_type" : pickedMood.pmType as Int,
            "MFJ_imageAdded" : !pickedMood.pmJournalImage.isEqual(UIImage()) as Bool,
            "MFJ_recheckinHours" : pickedMood.recheckInHours
        ])
        
        //Reset
        pickedMood.resetPickedMood()
        //Dismiss
        dismissMoodSheet()
    }
    
    func dismissMoodSheet() {
        //Post saving or delelting the journal entry
        NotificationCenter.default.post(
            name: .didDismissMoodSheet,
            object: nil
        )
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)

    }
}




struct WriteMoodJournalView_Previews: PreviewProvider {
    static var previews: some View {
        let pm = PickedMood()
        pm.pmColor = ColorManager.pastelRed
        pm.pmTitle = "Furious"
        pm.pmEmoji = "😡"
        pm.pmJournalImage = UIImage(named: "testFlower")!
        return Group {
            WriteMoodJournalView()
                .environmentObject(pm)
                .previewDevice(PreviewDevice(rawValue: "iPhone 6S"))
                .previewDisplayName("iPhone 6S")
            
            WriteMoodJournalView()
            .environmentObject(pm)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
            .previewDisplayName("iPhone 11 Pro")
        }
    }
}
