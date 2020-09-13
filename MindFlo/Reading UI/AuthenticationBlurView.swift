//
//  AuthenticationBlurView.swift
//  MindFlo
//
//  Created by Adit Gupta on 10/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import SwiftUIVisualEffects
import LocalAuthentication

struct AuthenticationBlurView: View {
    @Binding var authenticatedUser: Bool
    @Binding var userSettings: UserSettings
    
    var body: some View {
        ZStack {
            if userSettings.faceID && !authenticatedUser {
                ZStack(alignment: .top){
                    Color.black.opacity(0.1)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        Spacer()
                        Button(action: {
                            self.authenticate()
                        }) {
                            Text("Retry")
                        }
                        Spacer()
                        Image("mindfloTypeLogo")
                            .scaleEffect(0.9)
                    }
                    .padding(.vertical, 48)
                }
                .background(BlurEffect())
            } else {
                EmptyView()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: authenticate)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if !self.authenticatedUser && self.userSettings.faceID {
                self.authenticate()
            }
            print(" Moving back to foreground!")
        }
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to secure your Mindflo data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        // authenticated successfully
                        self.authenticatedUser = true
                    } else {
                        // there was a problem
                        self.authenticatedUser = false
                    }
                }
            }
        } else {
            // no biometrics
            userSettings.faceID = false
        }
    }
}


struct AuthenticationBlurView_Previews: PreviewProvider {
    static var previews: some View {
        let us = UserSettings()
        us.faceID = true
        return AuthenticationBlurView(authenticatedUser: .constant(false), userSettings: .constant(us))
    }
}
