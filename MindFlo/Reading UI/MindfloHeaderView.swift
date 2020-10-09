//
//  MindfloHeaderView.swift
//  MindFlo
//
//  Created by Adit Gupta on 17/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct MindfloHeaderView: View {
    @Binding var userSettings: UserSettings
    @Binding var isNavigationBarHidden: Bool
    @Binding var showSettingsView: Bool
    @State var showPrivacySheet = false
    var body: some View {
        HStack{
            ZStack {
                //Setting button
                NavigationLink(destination: SettingsMainView(userSettings: $userSettings, isNavigationBarHidden: $isNavigationBarHidden), isActive: $showSettingsView) {
                    Image("HomePreferencesCTA")
                        .onTapGesture {
                            //Haptic feedback
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            showSettingsView.toggle()
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 32)
            
            Spacer()
            
            Image("HomeLogoType").padding(.top, 8)
            Spacer()
            
            Button(action: {
                //Haptic feedback
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                self.showPrivacySheet.toggle()
            }) {
                
                Image("HomePrivacyCTA")
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $showPrivacySheet) {
                NavigationView{
                    PrivacyPromiseView()
                }
            }
            
        }
        .padding(.top, 8)
    }
}

struct MindfloHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MindfloHeaderView(userSettings: .constant(UserSettings()), isNavigationBarHidden: .constant(false), showSettingsView: .constant(false))
    }
}
