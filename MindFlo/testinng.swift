//
//  testinng.swift
//  MindFlo
//
//  Created by Adit Gupta on 17/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct testinng: View {
    @State private var showSheet = false
    @State var txt = ""
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack{
                    Button("Sheet ->") {
                        self.showSheet.toggle()
                    }
                    .sheet(isPresented: $showSheet, content: {
                        ZStack{
                            ColorManager.pastelRed.edgesIgnoringSafeArea(.all)
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
                                        
                                    }) {
                                        VStack {
                                            HStack(alignment: .center, spacing: 16) {
                                                //emoji
                                                Text("😋")
                                                    .font(.system(size: 40))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.black)
                                                
                                                VStack(alignment: .leading) {
                                                    //Mood title + Date
                                                    Text("Happy")
                                                    .font(.system(size: 24))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color.black.opacity(0.8))

                                                    Text("21 Sep")
                                                     .font(.system(size: 12))
                                                        .foregroundColor(Color.black.opacity(0.5))
                                                }
                                                
                                            }
                                            
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                    }) {
  
                                            Image(systemName: "stopwatch.fill")
                                                .font(.system(size: 28, weight: .semibold))
                                                .foregroundColor(.black)
                                                .opacity(0.50)
                                                .padding(.all, 8)
                                        
                                    }
                                    
                                    Spacer().frame(width: 8)
                                    
                                    Button(action: {
                                    }) {
                                        Image(systemName: "arrow.up.circle.fill")
                                            .font(.system(size: 32))
                                            .foregroundColor(.black)
                                            .opacity(0.30)
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
                                        Text("What made you feel this way?")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color.black.opacity(0.6))
                                        .padding(.leading, 4)
                                        .transition(.slide)
                                        
                                        Spacer()
                                    }
                                    .frame(height: 24)
                                    .clipped()
                                    
                                    AutoFocusTextInputView(text: $txt, isFirstResponder: true)
                                        .background(Color.blue)
                                        
                                }
                                .padding(.horizontal, 16)
                                HStack{
                                    Image(systemName: "circle")
                                    Image(systemName: "square")
                                }
                            
                            }
                        }
                    })
                }
            }
        }
    }
}

struct testinng_Previews: PreviewProvider {
    static var previews: some View {
        testinng()
    }
}
