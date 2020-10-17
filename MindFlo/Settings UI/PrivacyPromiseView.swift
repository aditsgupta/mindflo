//
//  PrivacyPromise.swift
//  MindFlo
//
//  Created by Adit Gupta on 15/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct PrivacyPromiseView: View {
    @Environment(\.openURL) var openURL //to open Safari links

    var body: some View {
        ScrollView {
            HStack{
                Spacer()
                Image("privacyPromiseBanner")
                    .padding(.vertical, 40)
                Spacer()
            }
            Text("Mindflo is the safest space on the internet for you to express freely. These four tenets help us ensure your data’s privacy & safety .")
                .font(.body)
                .padding()
            ForEach(1 ..< 5) { item in
                mfListAccordionView(item: item)
            }
            
            Button(action: {

                let urlString = "https://aditsgupta.com/MindfloPrivacyPolicy.html".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                openURL(URL(string: urlString!)!)
                
            }, label: {
                Text("Read our Privacy Policy →")
                    .foregroundColor(.gray)
            })
            .buttonStyle(PlainButtonStyle())
            .padding(24)
        }
        .navigationBarTitle("Privacy promise")
    }
}

struct mfListAccordionView: View {
    var item: Int
    @State private var showDetails = false
    var privacyPromiseContent = PrivacyPromiseStore().allPromises
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                Image(systemName: showDetails ? "\(item).square.fill": "\(item).square")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.gray)
                    .padding(.trailing)
                Text("\(privacyPromiseContent[item].title)")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: showDetails ? "chevron.up": "chevron.down")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(ColorManager.buttonGrey)
            }
            .padding([.all])
            
            
            if self.showDetails {
                Group{
                    ForEach(privacyPromiseContent[item].bulletPoints.indices){index in
  
                            Text("\(self.privacyPromiseContent[self.item].bulletPoints[index])")
                                .font(.system(.body))
                                .lineLimit(nil)
                                .padding(.leading, 64)
                                .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding([.trailing, .vertical], 8)
                
            } else {
                EmptyView()
            }
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color.black.opacity(0.10))
                .padding(.leading, 64)
                .padding(.top, 0)
            
        }
            
        .onTapGesture {

               self.showDetails.toggle()

        }
    }
}

struct PrivacyPromise_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPromiseView()
    }
}
