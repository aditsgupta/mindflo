//
//  CircularMoodButton.swift
//  MindFlo
//
//  Created by Adit Gupta on 09/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct CircularMoodButton: View {
    @Binding var mood: Mood
    @EnvironmentObject var pickedMood: PickedMood
    
    var body: some View {
        ZStack {
            Button(action: {
                self.pickedMood.pmColor = self.mood.moodColor
                self.pickedMood.pmTitle = self.mood.moodTitles.first ?? ""
                self.pickedMood.pmEmoji = self.mood.moodEmoji
                //Taptic feedback
                UISelectionFeedbackGenerator().selectionChanged()
                
            }) {
                ZStack {
                    Circle()
                        .fill(mood.moodColor.opacity(1.0))
                        .frame(width: 48.0, height: 48.0)
                        .background(
                            Circle()
                                .offset(x: -1, y: -2)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.5), radius: 0, x: 1, y: 2)
                            //.strokeBorder(ColorManager.bgGrey, lineWidth: 4.0)
                        )
                        .clipShape(Circle()) //Improves the smoothening of edges
                    
                    Text("\(mood.moodEmoji)")
                        .font(.system(size: 28))
                }
            }
            .contextMenu{
                ForEach(mood.moodTitles, id: \.self){ title in
                    Button(action: {
                        // change text and color
                        self.pickedMood.pmColor = self.mood.moodColor
                        self.pickedMood.pmTitle = title
                        self.pickedMood.pmEmoji = self.mood.moodEmoji
                        self.pickedMood.pmJournalDate = Date()
                        self.pickedMood.writeJournalWithPickedMood.toggle()
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
