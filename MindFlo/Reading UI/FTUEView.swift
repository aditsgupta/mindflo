//
//  FTUEView.swift
//  MindFlo
//
//  Created by Adit Gupta on 16/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct FTUEView: View {
    @Binding var userSettings: UserSettings
    @State var showAddNameSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image("FTUE_illustration\(userSettings.avatarID)")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(height: 240, alignment: .bottom)
                Spacer()
            }
            .padding()
            
            Text("Hey \(userSettings.name), start your journey here.")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical)
            
            
            Text("Allow yourself a minute to check in with your mind. Reflect on how an event, a person or this day made you feel.")
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding(24)
        .sheet(isPresented: $showAddNameSheet, content: {
            NavigationView{
                AddNameView(userSettings: $userSettings)
            }
        })
        .onAppear(){
            if userSettings.name.isEmpty{
                showAddNameSheet = true
            }
            else{
                showAddNameSheet = false
            }
        }
    }
}

struct FTUEView_Previews: PreviewProvider {
    static var previews: some View {
        FTUEView(userSettings: .constant(UserSettings()))
    }
}
