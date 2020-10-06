//
//  testinng.swift
//  MindFlo
//
//  Created by Adit Gupta on 17/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct testinng: View {
    @State private var showSheet = false
    @State var txt = ""
    var body: some View {
        
        NavigationView{
            VStack {
                HStack{
                    //Dragbar
                    Rectangle()
                        .frame(width: 36, height: 4, alignment: .center)
                        .cornerRadius(4)
                        .foregroundColor(Color.black.opacity(0.3))
                        .padding(.vertical, 8)
                }
                
            }
        }
    }
}
        
        
        struct testinng_Previews: PreviewProvider {
            static var previews: some View {
                testinng()
            }
        }
