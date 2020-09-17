//
//  EditMoodJournalView.swift
//  MindFlo
//
//  Created by Adit Gupta on 10/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

struct EditMoodJournalView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //Edit values
    @EnvironmentObject var pickedMoodEdit: PickedMoodEdit
    //Save into...
    var mindFloEntryEdit: MoodJournalEntry
    
    //Show alerts and sheets
    @State private var showGalleryPicker: Bool = false
    @State private var showCameraPicker: Bool = false
    @State private var showJournalDeleteAlert: Bool = false
    @State private var showImageDeleteAlert: Bool = false
    @State private var showColorPicker: Bool = false
    @State private var isFocussed: Bool = true
    
    @State private var toolbarPadding: CGFloat = 16
    @State var journalUIImage = UIImage()
    
    //Dateformatter ----> Add from Helper
    static let dateFormat: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        return dateformatter
    }()
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(hex: pickedMoodEdit.moodColorHexCode)
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
                        //Mood editing is currently not allowed
                        
                    }) {
                        
                        VStack {
                            HStack(alignment: .center, spacing: 16) {
                                //emoji
                                Text("\(pickedMoodEdit.moodEmoji)")
                                    .font(.system(size: 40))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                VStack(alignment: .leading) {
                                    //Mood title + Date
                                    Text("\(pickedMoodEdit.moodTitle)")
                                        .font(.system(size: 24))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black.opacity(0.8))
                                    
                                    Text("\(pickedMoodEdit.journalDate, formatter: Self.dateFormat)")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black.opacity(0.5))
                                }
                                
                            }
                            
                        }
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    Spacer()
                    
                    
                    Button(action: {
                        //Save Journal primary action
                        if !self.pickedMoodEdit.journalText.isEmpty {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            //REPLACE WITH UPDATEJOURNAL()
                            self.updateMoodJournal()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        else{
                            UINotificationFeedbackGenerator().notificationOccurred(.error)
                        }
                        
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.black)
                            .opacity(0.90)
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
                
                
                VStack (alignment: .leading, spacing: 4) {
                    //Textfield for Journal
                    insertHintText()
                        .font(.system(size: 18))
                        .foregroundColor(Color.black.opacity(0.6))
                        .padding(.leading, 4)
                    
                    AutoFocusTextInputView(text: $pickedMoodEdit.journalText, isFirstResponder: isFocussed)
                }
                .padding(.horizontal, 16)
                
                //Bottom Toolbar
                HStack(alignment: .bottom, spacing: 48) {
                    if pickedMoodEdit.journalImage == UIImage() {
                        Button(action: {
                            //Take a picture
                            self.showCameraPicker.toggle()
                            //remove Text focus keyboard
                            self.dismissKeyboard()
                            
                        }) {
                            Image(systemName: "camera")
                                .font(.system(size: 20.0, weight: .bold))
                                .foregroundColor(.black)
                                .opacity(0.9)
                        }
                        .sheet(isPresented: $showCameraPicker) {
                            //Text("Replace when Binding is ready")
                            ZStack {
                                Color.black.edgesIgnoringSafeArea(.all)
                                CameraImagePicker(selectedImage: self.$pickedMoodEdit.journalImage)
                                    .edgesIgnoringSafeArea(.all)
                            }
                        }
                        
                        
                        
                        Button(action: {
                            // Choose from gallery
                            self.showGalleryPicker.toggle()
                            //remove Text focus keyboard
                            self.dismissKeyboard()
                            
                        }) {
                            Image(systemName: "photo")
                                .font(.system(size: 20.0, weight: .bold))
                                .foregroundColor(.black)
                                .opacity(0.9)
                        }
                        .sheet(isPresented: $showGalleryPicker) {
                            //Text("Replace when Binding is ready")
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$pickedMoodEdit.journalImage)
                        }
                    }
                    else {
                        //show PickedImage preview with delete option
                        Button(action: {
                            //remove Text focus keyboard
                            self.dismissKeyboard()
                            //Delete alert
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            self.showImageDeleteAlert.toggle()
                        }) {
                            ZStack(alignment: .topTrailing) {
                                
                                Image(uiImage: pickedMoodEdit.journalImage).resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(pickedMoodEdit.journalImage.size, contentMode: .fill)
                                    .frame(width: 108, height: 108, alignment: .center)
                                    .cornerRadius(16.0)
                                
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.white.opacity(1))
                                    .shadow(radius: 1)
                                    .padding(.all, 8)
                            }
                        }
                        .actionSheet(isPresented: $showImageDeleteAlert) {
                            ActionSheet(
                                title: Text("Delete this photo?"),
                                buttons: [.destructive(Text("Delete"),
                                                       action: {
                                                        UINotificationFeedbackGenerator().notificationOccurred(.error)
                                                        self.pickedMoodEdit.journalImage = UIImage()
                                }), .cancel()]
                            )
                        }
                    }
                    
                    
                    Button(action: {
                        //remove Text focus keyboard
                        self.dismissKeyboard()
                        // Show color picker
                        self.showColorPicker.toggle()
                    }) {
                        Image(systemName: "square.lefthalf.fill")
                            .font(.system(size: 20.0, weight: .bold))
                            .foregroundColor(.black)
                            .opacity(0.9)
                    }
                    .sheet(height: SheetHeight.points(300), isPresented: self.$showColorPicker, content: {
                        ColorPickerGridView(showColorPickerGrid: self.$showColorPicker, fromView: "EditMoodJournalView")
                            .environmentObject(self.pickedMoodEdit)
                    })
                    
                    Spacer()
                    Button(action: {
                        //Dismiss  Keyboard
                        self.dismissKeyboard()
                    }) {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .font(.system(size: 20.0, weight: .bold))
                            .foregroundColor(.black)
                            .opacity(0.9)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, (toolbarPadding))
                .onReceive(Publishers.keyboardHeight) {
                    let keyboardHeight = $0
                    let bottomSafePadding =  (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
                    self.toolbarPadding = keyboardHeight + 16
                    if keyboardHeight == 0 {
                        self.toolbarPadding = bottomSafePadding + 16
                    }
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    
    func insertHintText() -> AnyView{
        switch self.pickedMoodEdit.journalTextCount {
        case 0..<15:
            return AnyView(Text("What triggered this feeling?"))
        case 15..<30:
            return AnyView(Text("Write why you felt this way"))
        default:
            return AnyView(Text("What triggered this feeling? Why? "))
        }
    }
    
    func updateMoodJournal(){
        //Update into MOC
        managedObjectContext.performAndWait {
            // CODE TO SAVE EDITIED ENTRY TO CONTEXT
            mindFloEntryEdit.moodEmoji = pickedMoodEdit.moodEmoji
            mindFloEntryEdit.moodTitle = pickedMoodEdit.moodTitle
            mindFloEntryEdit.moodColorHexCode = pickedMoodEdit.moodColorHexCode
            mindFloEntryEdit.journalText = pickedMoodEdit.journalText
            mindFloEntryEdit.journalDate = pickedMoodEdit.journalDate
            
            if pickedMoodEdit.journalImage != UIImage() {
                mindFloEntryEdit.journalImage = pickedMoodEdit.journalImage.jpegData(compressionQuality: 0.80)
            }
            else{
                mindFloEntryEdit.journalImage = nil
            }
            
            //Save the moc
            do {
                try self.managedObjectContext.save()
            }
            catch{
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
            //Firebase
            Analytics.logEvent("editMF_SaveButton", parameters: [
                "MFJ_chars" : pickedMoodEdit.journalTextCount as Int,
                "MFJ_imageAdded" : !pickedMoodEdit.journalImage.isEqual(UIImage()) as Bool
            ])
            
        }
    }
    
    func dismissMoodSheet() {
        //Post saving or deleting the journal entry
        NotificationCenter.default.post(
            name: .didDismissMoodSheet,
            object: nil
        )
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}

//All extensions for Keyboard height from WriteMoodJournal are available here


struct EditMoodJournalView_Previews: PreviewProvider {
    static var previews: some View {
        let pm = PickedMoodEdit()
        pm.moodColorHexCode = "eeeeee"
        pm.moodTitle = "Furious"
        pm.moodEmoji = "😡"
        pm.journalText = "This is my journal text entry"
        return Group {
            EditMoodJournalView(mindFloEntryEdit: MoodJournalEntry())
                .environmentObject(pm)
                .previewDevice(PreviewDevice(rawValue: "iPhone 6S"))
                .previewDisplayName("iPhone 6S")
            
            EditMoodJournalView(mindFloEntryEdit: MoodJournalEntry())
                .environmentObject(pm)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
                .previewDisplayName("iPhone 11 Pro")
        }
    }
}

