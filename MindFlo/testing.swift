//
//  testing.swift
//  MindFlo
//
//  Created by Adit Gupta on 06/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct testing: View {

    @State private var hintNum = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack {
                Button(action: {
                    withAnimation {
                        self.hintNum += 1
                    }
                }) {
                    Text("Next Hint")
                }
                .padding()
                Button("Previous Hint") {
                    withAnimation {
                        self.hintNum -= 1
                    }
                }
            .padding()
                
            }
            //Spacer()
            VStack{
                hintText()
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            }
            .frame(height: 24)
            //.clipped()
        }
        .clipped()
    }
    func hintText() -> AnyView{
        switch self.hintNum {
        case 0:
            return AnyView(Text("Hi Adit"))
        case 1:
            return AnyView(Text("Waasup yo?"))
        default:
            return AnyView(Text("How's it going??"))
        }
    }
}

struct testing_Previews: PreviewProvider {
    static var previews: some View {
        testing()
    }
}
