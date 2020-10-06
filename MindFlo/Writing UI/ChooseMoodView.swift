//
//  ChooseMoodView.swift
//  MindFlo
//
//  Created by Adit Gupta on 06/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import Combine
import Firebase
import SwiftUIVisualEffects

struct ChooseMoodView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var pickedMood: PickedMood
    
    var body: some View {
        
        
        ZStack(alignment: .top) {
            pickedMood.pmColor.edgesIgnoringSafeArea(.top)
                .opacity(0.40)
                .overlay(
                    Image("mindfloPattern")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.top)
                    ,
                    alignment: .center
                )
            VStack {
                VStack {
                    HStack{
                        //Dragbar
                        Rectangle()
                            .frame(width: 36, height: 4, alignment: .center)
                            .cornerRadius(4)
                            .foregroundColor(Color.black.opacity(0.3))
                            .padding(.vertical, 8)
                    }
                    HStack(alignment: .top) {
                        //Top actions
                        Button(action: {
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            self.pickedMood.resetPickedMood()
                        }) {
                            Image(systemName: "minus.circle")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(Color.black.opacity(!self.pickedMood.pmTitle.isEmpty ? 0.8 : 0.2))
                        }
                        
                        Spacer()
                        ZStack {
                            //Preview of emoji + color
                            Circle()
                                .fill(pickedMood.pmColor)
                                .frame(width: 96, height: 96)
                                .overlay(
                                    Circle()
                                        .strokeBorder(Color.white.opacity(1.0), lineWidth: 8)
                                )
                            Text("\(pickedMood.pmEmoji)")
                                .font(.system(size: 40.0))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .scaleEffect(1.1)
                                .animation(.default)
                        }
                        
                        Spacer()
                        Button(action: {
                            //haptic feedbback
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                            if !self.pickedMood.pmTitle.isEmpty {
                                
                                self.pickedMood.pmJournalDate = Date()
                                self.pickedMood.writeJournalWithPickedMood.toggle()
                                
                                //Firebase
                                Analytics.logEvent("writeMF_Library_ChooseMood", parameters: [
                                    "source" : "MoodLibrary_tap",
                                    "moodtype" : self.pickedMood.pmType as Int
                                ])
                            }
                            
                        }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(Color.black.opacity(!self.pickedMood.pmTitle.isEmpty ? 0.8 : 0.2))
                        }
                    }
                    .padding([.horizontal], 24)
                    .padding(.top, 12)
                    
                    //textbox
                    TextField("Today I feel…", text: $pickedMood.pmTitle)
                        .font(.system(size: 24, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .frame(height: 56)
                        .background(
                            Rectangle()
                                .foregroundColor(Color.gray.opacity(0.1))
                                .clipped()
                        )
                        .background(BlurEffect())
                        .cornerRadius(12)
                        .padding(.all, 24)
                }
                MoodsVerticalGrid(moodStore: MoodStore())
                    .background(Color(.white).edgesIgnoringSafeArea(.bottom))
                    .frame(width: UIScreen.main.bounds.width)
            }
        }
        
        .padding(.horizontal)
        
        .navigate(to: WriteMoodJournalView(), when: $pickedMood.writeJournalWithPickedMood)
        .onReceive(NotificationCenter.default.publisher(for: .didDismissMoodSheet)) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
extension Notification.Name {
    static var didDismissMoodSheet: Notification.Name {
        return Notification.Name("Mood sheet has been dismissed")
    }
}
struct ChooseMoodView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMood = PickedMood()
        sampleMood.pmColor = ColorManager.pastelBlue
        return ChooseMoodView().environmentObject(sampleMood)
    }
}
