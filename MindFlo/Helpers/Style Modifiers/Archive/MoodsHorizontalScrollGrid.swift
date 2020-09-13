//
//  MoodPickerGrid.swift
//  MindFlo
//
//  Created by Adit Gupta on 09/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct MoodsHorizontalScrollGrid: View {
    var moodStore = MoodStore()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(moodStore.happy) { mood in
                            VStack {
                                Button(action: {
                                    //Update Preview Color and Textfield
                                }) {
                                    CircularMoodButton(mood: .constant(mood))
                                }
                                
                                Text("\(mood.moodTitles.first ?? "")")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame( maxWidth: 72)
                                    .lineLimit(1)
                            }
                            .padding([.bottom, .trailing], 16)
                            
                        }
                    }
                    .padding(.leading, 16)
                }
                
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(moodStore.sad) { mood in
                            VStack {
                                Button(action: {
                                    //Update Preview Color and Textfield
                                }) {
                                    CircularMoodButton(mood: .constant(mood))
                                }
                                
                                Text("\(mood.moodTitles.first ?? "")")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame( maxWidth: 72)
                                    .lineLimit(1)
                            }
                            .padding([.bottom, .trailing], 16)
                            
                        }
                    }
                    .padding(.leading, 16)
                }
                
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(moodStore.angry) { mood in
                            VStack {
                                Button(action: {
                                    //Update Preview Color and Textfield
                                }) {
                                    CircularMoodButton(mood: .constant(mood))
                                }
                                
                                Text("\(mood.moodTitles.first ?? "")")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame( maxWidth: 72)
                                    .lineLimit(1)
                            }
                            .padding([.bottom, .trailing], 16)
                            
                            
                        }
                    }
                    .padding(.leading, 16)
                }
                
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(moodStore.fearful) { mood in
                            VStack {
                                Button(action: {
                                    //Update Preview Color and Textfield
                                }) {
                                    CircularMoodButton(mood: .constant(mood))
                                }
                                
                                Text("\(mood.moodTitles.first ?? "")")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame( maxWidth: 72)
                                    .lineLimit(1)
                            }
                            .padding([.bottom, .trailing], 16)
                            
                        }
                    }
                    .padding(.leading, 16)
                }
                
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(moodStore.disgust) { mood in
                            VStack {
                                Button(action: {
                                    //Update Preview Color and Textfield
                                }) {
                                    CircularMoodButton(mood: .constant(mood))
                                }
                                
                                Text("\(mood.moodTitles.first ?? "")")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame( maxWidth: 72)
                                    .lineLimit(1)
                            }
                            .padding([.bottom, .trailing], 16)
                            
                        }
                    }
                    .padding(.leading, 16)
                }
            }
            .padding(.vertical, 16)
        }
    }
}

struct MoodPickerGrid_Previews: PreviewProvider {
    static var previews: some View {
        MoodsHorizontalScrollGrid(moodStore: MoodStore())
    }
}

