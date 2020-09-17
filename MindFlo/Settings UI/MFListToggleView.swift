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
    var divider = true
    
    var body: some View {
        HStack(alignment: .center){
                Image(systemName: "\(icon)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.black.opacity(toggleState ? 0.60 : 0.30))
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
                //Divider
                if divider {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color.black.opacity(0.10))
                } else {
                    EmptyView()
                }
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
