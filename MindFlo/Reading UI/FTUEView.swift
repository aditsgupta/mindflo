//
//  FTUEView.swift
//  MindFlo
//
//  Created by Adit Gupta on 16/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct FTUEView: View {
    let userSettings = UserSettings()
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image("FTUE_illustration2")
                Spacer()
            }
            
            Text("\(userSettings.name), check in with your mind for a minute.")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical)
            
            
            Text("Reflect on an event, person or object in your life and how that made you feel.")
                .font(.body)
                .foregroundColor(.gray)
        }
        
        .padding()
    }
}

struct FTUEView_Previews: PreviewProvider {
    static var previews: some View {
        FTUEView()
    }
}
