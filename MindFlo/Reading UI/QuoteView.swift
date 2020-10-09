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
    var quoteNum: Int { mindfloDay % quotes.count } //Ensure quotes index is never out of bounds
    @State private var showShareQuoteSheet = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(alignment: .top) {
                Image("quoteIcon")
                    .padding(.top, 4)
                    .padding(.horizontal, 24)
                
                Button(action: {
                    self.showShareQuoteSheet.toggle()
                    UISelectionFeedbackGenerator().selectionChanged()
                    
                }, label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(quotes[quoteNum].title)")
                                .font(.system(.body))
                                .foregroundColor(Color(.black).opacity(0.80))
                                .multilineTextAlignment(.leading)
                                .lineLimit(4)
                                .minimumScaleFactor(0.8)
                            Spacer()
                        }
                        
                        Text("- \(quotes[quoteNum].author) ")
                            .font(.system(size: 14))
                            .italic()
                            .multilineTextAlignment(.leading)
                            .padding(.top, 8)
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                })
                .buttonStyle(PlainButtonStyle())
                .actionSheet(isPresented: $showShareQuoteSheet, content: {
                    ActionSheet(
                        title: Text("\"\(quotes[quoteNum].title) \""),
                        buttons: [.default(Text("Share this quote"), action: {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            self.setupQuoteShareSheet()
                        }), .cancel()]
                    )
                })
            }
             .padding([.top], 24)
        }
    }
    
    func setupQuoteShareSheet(){
        let text = "\(quotes[quoteNum].title) - \(quotes[quoteNum].author) via Mindflo"
        
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(mindfloDay: 21 )
    }
}
