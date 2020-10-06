//
//  AddNameView.swift
//  MindFlo
//
//  Created by Adit Gupta on 08/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct AddNameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var userSettings: UserSettings
    @State var avatar = 0
    
    var body: some View {
        Form {
            HStack(alignment: .center){
                ForEach(1..<4) { (index) in
                    Image("avatar\(index)")
                        .background(Circle()
                                        .foregroundColor(avatar == index ? ColorManager.pastelBlue : ColorManager.bgGrey)
                                        .scaleEffect(1.2)
                        )
                        .scaleEffect(avatar == index ? 1.50 : 1.0)
                        .animation(.default)
                        .onTapGesture(){
                            print("Tapped!!!")
                            avatar = index
                            userSettings.avatarID = index
                            
                        }
                    if(index < 3){
                        Spacer()
                    }
                }
                
            }
            .padding(.all, 24)
            TextField("Jen Doe", text: $userSettings.name)
                .font(.system(size: 20))
                .frame(height: 64)
            
            Button(action: {
                //Dimiss & save time
                if !userSettings.name.isEmpty {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            }) {
                ZStack {
                    ColorManager.buttonGrey
                    Text("Save")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                .frame(height: 56)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.vertical)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .onAppear(){
            avatar = userSettings.avatarID
        }
        .onDisappear(){
            userSettings = UserSettings()
        }
        .navigationBarTitle("Setup your profile")
        
    }
}

struct AddNameView_Previews: PreviewProvider {
    static var previews: some View {
        AddNameView(userSettings: .constant(UserSettings()))
    }
}
