//
//  MFListToggleView.swift
//  MindFlo
//
//  Created by Adit Gupta on 06/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct MFListToggleView: View {
    var title = ""
    var icon = ""
    @Binding var toggleState: Bool
    
    var body: some View {
        HStack(alignment: .center){
            ZStack {
                Circle()
                    .frame(width: 32, height: 32)
                    .foregroundColor(ColorManager.bgGrey)
                Image(systemName: "\(icon)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color.black.opacity(0.8))
                
            }
            .padding()
            
            VStack {
                Spacer()
                Toggle(isOn: $toggleState) {
                    Text("\(title)")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                }
                .padding(.trailing)
                
                Spacer()
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(ColorManager.buttonGrey)
                    .padding(.top, 0)
            }
            
            
        }
        .frame(height: 64)
        .background(Color.white)
    }
}


struct MFListToggleView_Previews: PreviewProvider {
    static var previews: some View {
        MFListToggleView(title: "FaceID lock", icon: "faceid", toggleState: .constant(true))
    }
}
