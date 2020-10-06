//
//  CircularMoodButton.swift
//  MindFlo
//
//  Created by Adit Gupta on 09/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import Firebase

struct CircularMoodButton: View {
    @Binding var mood: Mood
    @EnvironmentObject var pickedMood: PickedMood
    
    var body: some View {
        ZStack {
            Button(action: {
                self.pickedMood.pmColor = self.mood.moodColor
                self.pickedMood.pmTitle = self.mood.moodTitles.first ?? ""
                self.pickedMood.pmEmoji = self.mood.moodEmoji
                self.pickedMood.pmType = self.mood.moodType
                //Taptic feedback
                UISelectionFeedbackGenerator().selectionChanged()
                
            }) {
                ZStack {
                    Circle()
                        .fill(mood.moodColor.opacity(0.95))
                        .frame(width: 56.0, height: 56.0)
                        .background(
                            Circle()
                                .offset(x: -1, y: -2)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.6), radius: 0, x: 1, y: 2)
                                //.strokeBorder(ColorManager.bgGrey, lineWidth: 4.0)
                        )
                        .clipShape(Circle()) //Improves the smoothening of edges
                    
                    Text("\(mood.moodEmoji)")
                        .font(.system(size: 28))
                }
            }
            .contextMenu{
                //Forcetouch context menu
                ForEach(mood.moodTitles, id: \.self){ title in
                    Button(action: {
                        // change text and color
                        self.pickedMood.pmColor = self.mood.moodColor
                        self.pickedMood.pmTitle = title
                        self.pickedMood.pmEmoji = self.mood.moodEmoji
                        self.pickedMood.pmType = self.mood.moodType
                        self.pickedMood.pmJournalDate = Date()
                        self.pickedMood.writeJournalWithPickedMood.toggle()
                        
                        //Firebase
                        Analytics.logEvent("writeMF_Library_ChooseMood", parameters: [
                            "source" : "MoodLibrary_ForceTouch",
                            "moodtype" : self.pickedMood.pmType as Int
                        ])
                    }) {
                        Text("\(title)")
                        Image(systemName: "arrow.right.circle")
                    }
                }
            }
        }
    }
}

struct CircularMoodButton_Previews: PreviewProvider {
    static var previews: some View {
        CircularMoodButton(mood: .constant(Mood(moodType: 2, moodEmoji: "😞", moodTitles: ["Sad", "Gloomy", "Dejected" ] )))
    }
}
