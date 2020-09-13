//
//  ColorGridView.swift
//  MindFlo
//
//  Created by Adit Gupta on 11/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct ColorPickerGridView: View {
    @Binding var showColorPickerGrid: Bool
    var fromView: String
    var body: some View {
        VStack {
            HStack{
                //Dragbar
                Rectangle()
                    .frame(width: 36, height: 4, alignment: .center)
                    .cornerRadius(2)
                    .foregroundColor(Color.black.opacity(0.3))
                    .padding(.top, 8)
            }
            .padding(.bottom, 24)
            HStack {
                Text("Choose a color")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.bottom, 24)
            HStack {
                
                ColorGridItem(colorOfItem: ColorManager.pastelRed, fromView: fromView, showColorPickerGrid: $showColorPickerGrid)
                Spacer()
                ColorGridItem(colorOfItem: ColorManager.pastelYellow, fromView: fromView, showColorPickerGrid: $showColorPickerGrid)
                Spacer()
                ColorGridItem(colorOfItem: ColorManager.pastelGreen, fromView: fromView, showColorPickerGrid: $showColorPickerGrid)
            }
            .padding(.bottom, 32)
            
            HStack {
                ColorGridItem(colorOfItem: ColorManager.pastelPurple, fromView: fromView, showColorPickerGrid: $showColorPickerGrid)
                Spacer()
                ColorGridItem(colorOfItem: ColorManager.pastelBlue, fromView: fromView, showColorPickerGrid: $showColorPickerGrid)
                Spacer()
                ColorGridItem(colorOfItem: ColorManager.bgGrey, fromView: fromView, showColorPickerGrid: $showColorPickerGrid)
            }
            Spacer()
        }
        .padding([.leading,.trailing], 24)
        .background(Color.white)
        .frame(maxHeight: 320)
    }
}

struct ColorGridItem: View {
    @EnvironmentObject var pickedMood: PickedMood
    @EnvironmentObject var pickedMoodEdit: PickedMoodEdit
    
    var colorOfItem = ColorManager.bgGrey
    var fromView: String
    @Binding var showColorPickerGrid: Bool
    
    var body: some View {
        Button(action: {
            //Add the color to the view Environment
            switch self.fromView {
            case "EditMoodJournalView":
                self.pickedMoodEdit.moodColorHexCode = self.colorOfItem.uiColor().hexString //crash here
            case "WriteMoodJournalView":
                self.pickedMood.pmColor = self.colorOfItem
            default:
                self.pickedMood.pmColor = self.colorOfItem
            }
            UISelectionFeedbackGenerator().selectionChanged()
            self.showColorPickerGrid = false
            
        }) {
            ZStack {
                Text("Aa")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .opacity(0.8)
                    .padding(.all)
            }
            .frame(width: 80, height: 80, alignment: .topLeading)
            .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(colorOfItem)
                        .offset(x: -2, y: -2)
                        .shadow(color: Color.black.opacity(0.10), radius: 0, x: 2, y: 2)
            )
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(colorOfItem)
            )
        }
        .buttonStyle(PlainButtonStyle())
        
    }
    
}

struct ColorPickerGridView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerGridView(showColorPickerGrid: .constant(true), fromView: "EditMoodJournalView")
    }
}
