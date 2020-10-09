//
//  MoodLoopingHint.swift
//  MindFlo
//
//  Created by Adit Gupta on 03/10/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct MoodLoopingHint: View {
    @State var isTapLoopComplete = false
    @State var isMenuLoopComplete = false
    private let animation = Animation.easeInOut(duration: 0.5).delay(1.5)
        .repeatForever(autoreverses: true)
    private let animationOption = Animation.easeOut(duration: 0.25).delay(1.75)
        .repeatForever(autoreverses: true)
    private let maxScale: CGFloat = 1.0
    
    var body: some View {
        
        ZStack {
            Circle()
                //.strokeBorder(ColorManager.bgGrey, lineWidth: 4)
                .foregroundColor(ColorManager.buttonGrey)
                .frame(width: 56)
                .background(
                    Circle()
                        .strokeBorder(ColorManager.bgGrey, lineWidth: 8)
                        .frame(width: 80)
                )
                .scaleEffect(isTapLoopComplete ? maxScale : 0.2)
                .animation(self.animation)
                .onAppear {
                    self.isTapLoopComplete.toggle()
                }
            //Mood Button Circle
            Circle()
                .frame(width: 44)
                .foregroundColor(ColorManager.bgGrey)
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .frame(width: 160, height: 100, alignment: .topTrailing)
                    .foregroundColor(ColorManager.buttonGrey.opacity(0.8))

                Rectangle()
                    .frame(width: 160, height: 8, alignment: .topTrailing)
                    .foregroundColor(.white)
            }
            .offset(x: -80, y: 50)
            .scaleEffect(isMenuLoopComplete ? maxScale : 0.1)
            .opacity(isMenuLoopComplete ? 1 : 0)
            .animation(self.animationOption)
            .onAppear {
                self.isMenuLoopComplete.toggle()
            }
        }
    }
}

struct MoodLoopingHint_Previews: PreviewProvider {
    static var previews: some View {
        MoodLoopingHint()
    }
}
