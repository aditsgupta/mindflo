//
//  RoundedButtonModifier.swift
//  MindFlo
//
//  Created by Adit Gupta on 06/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
import SwiftUI
struct RoundedButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.black).opacity(0.85)
            .padding()
            .frame(width: (UIScreen.main.bounds.width - 30), alignment: .center)
            .background(RoundedRectangle(cornerRadius: 8, style: .circular)
            .fill(Color.blue).opacity(0.2))
            .padding(.bottom, 8)
    }
}

extension View {
    func roundedButtonStyle() -> ModifiedContent<Self, RoundedButtonModifier> {
        return modifier(RoundedButtonModifier())
    }
}

struct RoundedButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
        }) {
            Text("😟 Anxious")
            .roundedButtonStyle()
        }
    }
}
