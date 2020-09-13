//
//  SettingsrowView.swift
//  MindFlo
//
//  Created by Adit Gupta on 06/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct MFListView: View {
    var title = ""
    var icon = ""
    
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
            
            
            
            VStack(alignment: .leading) {
                Spacer()
                HStack(alignment: .center) {
                    Text("\(title)")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.black.opacity(0.1))
                        .padding(.all)
                }
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

struct MFListView_Previews: PreviewProvider {
    static var previews: some View {
        MFListView(title: "FaceID lock", icon: "faceid")
    }
}
