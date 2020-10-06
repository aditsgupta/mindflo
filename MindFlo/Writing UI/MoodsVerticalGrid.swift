//
//  MoodsVerticalGrid.swift
//  MindFlo
//
//  Created by Adit Gupta on 16/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct MoodsVerticalGrid: View {
    var moodStore = MoodStore()
    let gridColumns = 4
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){

            ForEach(0..<getGridRows()) {rowIndex in
                HStack {
                    ForEach(0..<self.gridColumns) { columnIndex in
                        Spacer()
                        if self.isValidMoodIndex(rowIndex, columnIndex) {
                            VStack {
                                CircularMoodButton(mood: .constant(self.moodStore.allMoods[rowIndex * self.gridColumns + columnIndex]))
                                
                                Text("\(self.moodStore.allMoods[rowIndex * self.gridColumns + columnIndex].moodTitles.first ?? "")")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame( maxWidth: 80)
                                    .lineLimit(1)
                                
                            }
                        } else {
                            EmptyView()
                        }
                        Spacer()
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 4)
            }
            VStack(alignment: .center) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(ColorManager.bgGrey)
                
                MoodLoopingHint().scaleEffect(0.60)
                
                Text("Tip: Long press any mood for options")
                    .font(.caption)
                    .italic()
                    .foregroundColor(.gray)
                    .padding(.top, 24)
                
            }.padding(.vertical)
        }
        
    }
    
    private func getGridRows() -> Int{
        return (moodStore.allMoods.count/gridColumns)
    }
    private func isValidMoodIndex(_ rowIndex: Int, _ columnIndex: Int) -> Bool{
        if (rowIndex * columnIndex) > moodStore.allMoods.count {
            return false
        }
        return true
    }
}

struct MoodsVerticalGrid_Previews: PreviewProvider {
    static var previews: some View {
        MoodsVerticalGrid(moodStore: MoodStore())
    }
}
