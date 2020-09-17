//
//  CircularPrimaryButton.swift
//  MindFlo
//
//  Created by Adit Gupta on 05/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import UserNotifications
import Firebase

struct CircularPrimaryButton: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var pickedMood: PickedMood
    
    @Binding var showMoodSheet: Bool
    @State private var buttonPadding: CGFloat = 16.0

    var body: some View {
        //Floating action button to add Moodjournal
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    //Haptic feedback
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                   
                    //toggle sheet
                    self.pickedMood.writeJournalWithPickedMood = false
                    self.showMoodSheet.toggle()
                    //Firebase 
                    Analytics.logEvent("writeMF_AddButton", parameters: [
                        "source" : "home"
                    ])
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                            .frame(width: 80.0, height: 80.0)
                            .shadow(color: Color(.black).opacity(0.3), radius: 0, x: 2, y: 2)
                        
                        Image(systemName: "plus.square.fill")
                            .foregroundColor(.white)
                            .scaleEffect(2)
                    }
                    .padding(.bottom, (buttonPadding))
                }
                .buttonStyle(PlainButtonStyle())
                .onAppear(){
                    let bottomSafePadding =  (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
                    if bottomSafePadding > 0 {
                        self.buttonPadding = 0
                    }
                }
            }
        }
        .sheet(isPresented: $showMoodSheet) {
            ChooseMoodView()
                .environmentObject(self.pickedMood)
                .environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
}

struct CircularPrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        CircularPrimaryButton(showMoodSheet: .constant(false))
    }
}
