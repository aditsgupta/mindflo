//
//  FTUEView.swift
//  MindFlo
//
//  Created by Adit Gupta on 16/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import StoreKit

struct LifecycleView: View {
    @Environment(\.openURL) var openURL //to open Safari links
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let userSettings = UserSettings()
    private var ordinalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }()
    
    
    var body: some View {

        VStack(alignment: .leading) {
            HStack{
                Spacer()
                //Dragbar
                Rectangle()
                    .frame(width: 36, height: 4, alignment: .center)
                    .cornerRadius(4)
                    .foregroundColor(Color.black.opacity(0.3))
                    .padding(.top, 8)
                Spacer()
                
            }
            HStack {
                Spacer()
                Image("Lifecycle_illustration\(userSettings.avatarID)")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(height: 240
                           , alignment: .bottom)
                Spacer()
            }
            .padding()
            
            Text("Your \(ordinalFormatter.string(from: NSNumber(value: userSettings.mfJournalPosts))!) flo, Great work \(userSettings.name)!")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical)
            
            
            if !userSettings.notificationsAllowed {
                Group {
                    Text("Let's keep you flo'ing. Commit to your practice with daily check-ins. We have a whole journey ahead of us.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Button(action: {
                        NotificationsHelper().authorizeUserNotification()
                        
                        if userSettings.notificationsAllowed{
                            userSettings.morningCheckin = true
                            userSettings.eveningCheckin = true
                        }
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        ZStack {
                            ColorManager.buttonGrey
                            Text("Start daily check-ins")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        }
                        .frame(height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.vertical)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    
                    Text("Note: Mindflo uses notifications ONLY for check-ins. \nTap \"Allow\" on the alert when prompted.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .italic()
                }
            } else if userSettings.rateMindfloTaps < 2 {
                Group{
                    Text("Take a moment to soak in this milestone. We have a long journey ahead of us. :)")
                        .font(.body)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    //
                    Text("Loving Mindflo? A rating on the App Store goes a long way in helping spread the word.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .italic()
                        .padding(.top)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Button(action: {
                        //Update userSettings
                        userSettings.rateMindfloTaps += 1
                        if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene) }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        ZStack {
                            ColorManager.buttonGrey
                            HStack {
                                Image(systemName: "star.circle.fill")
                                    .font(.system(size: 20))
                                
                                Text("Rate on App Store")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.vertical)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
            } else {
                Group{
                    Text("Take a moment to soak in this milestone. We have a whole journey ahead of us. :)")
                        .font(.body)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        ZStack {
                            ColorManager.buttonGrey
                            Text("Done")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        }
                        .frame(height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.vertical)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        let urlString = "mailto:aditsgupta@gmail.com?subject=Minflo feedback".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        openURL(URL(string: urlString!)!)
                    }) {
                        ZStack {
                            Color.white
                            HStack {
                                Image(systemName: "envelope.open.fill")
                                        .font(.system(size: 18))
                                    .padding(2)
                                Text("Send feedback")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                            }
                            .opacity(0.8)
                        }
                        .frame(height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color.white)
    }
}

struct LifecycleView_Previews: PreviewProvider {
    static var previews: some View {
        LifecycleView()
    }
}
