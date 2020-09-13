//
//  QuoteView.swift
//  MindFlo
//
//  Created by Adit Gupta on 12/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct QuoteView: View {
    var mindfloDay: Int
    var quotes = QuoteStore().allQuotes
    var quoteNum: Int { mindfloDay % quotes.count }
    //Ensure quotes index is never out of bounds

    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(alignment: .top, spacing: 20) {
                Image("quoteIcon")
                    .padding(.leading, 8)
                    .padding(.top, 20)
                VStack(alignment: .leading) {
                    Text("\(quotes[quoteNum].title)")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                    Text("- \(quotes[quoteNum].author) ")
                        .font(.system(size: 14))
                        .italic()
                        .multilineTextAlignment(.leading)
                        .padding(.top, 8)
                        .foregroundColor(.gray)
                }
                .padding([.top, .leading])
            }
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(mindfloDay: 40 )
    }
}
