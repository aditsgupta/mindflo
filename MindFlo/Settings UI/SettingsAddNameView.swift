//
//  SettingsAddNameView.swift
//  MindFlo
//
//  Created by Adit Gupta on 08/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct SettingsAddNameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var userSettings: UserSettings
    var body: some View {
        Form {
            TextField("Add your name", text: $userSettings.name)
                .font(.system(size: 20))
                .frame(height: 64)
            
            Button(action: {
                    //Dimiss & save time
                self.presentationMode.wrappedValue.dismiss()
                }) {
                    ZStack {
                        ColorManager.buttonGrey
                        Text("Save Name")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                    .frame(height: 56)
                }
            .buttonStyle(PlainButtonStyle())
        }
        .navigationBarTitle("Add your name", displayMode: .inline)
        
    }
}

struct SettingsAddNameView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAddNameView(userSettings: UserSettings())
    }
}
