//
//  MFTimePicker.swift
//  MindFlo
//
//  Created by Adit Gupta on 07/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import Combine

struct MFTimePicker: View {
    //@ObservedObject var userSettings = UserSettings()
    
    @Binding var pickedTime: Date
    @Binding var showView: Bool
    
    var body: some View {
        VStack {
            DatePicker(" ", selection: $pickedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .environment(\.locale, Locale.current)
                
            Button(action: {
                //Dimiss modal
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                self.showView = false
                }) {
                    ZStack {
                        ColorManager.buttonGrey
                        Text("Save time")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                    .frame(height: 64)
                }
            .padding(.all)
            .buttonStyle(PlainButtonStyle())
        }
        .frame(height: 320)
        .background(Color.white)
    }
}

struct MFTimePicker_Previews: PreviewProvider {
    static var previews: some View {
        MFTimePicker(pickedTime: .constant(Date()), showView: .constant(true))
    }
}
