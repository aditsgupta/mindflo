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
    var divider = true
    
    var body: some View {
        HStack(alignment: .center){
            
            Image(systemName: "\(icon)")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.black.opacity(0.60))
                .padding()
            
            
            
            VStack(alignment: .leading) {
                Spacer()
                HStack(alignment: .center) {
                    Text("\(title)")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.black.opacity(0.1))
                        .padding(.all)
                }
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
    struct MFListView_Previews: PreviewProvider {
        static var previews: some View {
            MFListView(title: "FaceID lock", icon: "lock.shield.fill")
        }
}
