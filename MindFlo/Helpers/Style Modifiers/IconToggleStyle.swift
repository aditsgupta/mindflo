//
//  IconToggleStyle.swift
//  MindFlo
//
//  Created by Adit Gupta on 12/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
struct IconToggleStyle: ToggleStyle {
    var outlineIconName: String //make sure this has a corresponding fill icon
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            //configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "\(outlineIconName).fill" : "\(outlineIconName)")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.black)
                .opacity(configuration.isOn ? 0.90 : 0.30)
                .padding(.all, 8)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
