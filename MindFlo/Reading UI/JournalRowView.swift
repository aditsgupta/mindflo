//
//  JournalRowView.swift
//  MindFlo
//
//  Created by Adit Gupta on 30/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI

struct JournalRowView: View {
    var mindFloEntries: [MoodJournalEntry]
    
    @Binding var isNavigationBarHidden: Bool
    
    var body: some View {
            //Add each moodJournal item in a date section
            ForEach(mindFloEntries) { (mfEntry: MoodJournalEntry) in
				HStack(alignment: .top) {
					Spacer()
					.frame(width: 48)
					NavigationLink(destination: JournalDetailView(mindFloEntry: mfEntry, isNavigationBarHidden: self.$isNavigationBarHidden)) {
						VStack(alignment: .leading, spacing: 0){
							HStack{
								//Mood
								Text("\(mfEntry.moodEmoji ?? "")")
									.font(.callout)
								
								Text("\(mfEntry.moodTitle ?? "")")
									.font(.system(size: 16, weight: .semibold))
									.foregroundColor(Color(.black).opacity(0.75))
								
								Spacer()
								
								Text("\(mfEntry.journalDate?.timeShort.lowercased() ?? "")")
									.font(.footnote)
									.foregroundColor(Color(.black).opacity(0.5))
								
							}
							.padding([.bottom], 8)
							
							HStack(alignment: .top) {
								//Journal text and image
								Text("\(mfEntry.journalText ?? "")")
									.fixedSize(horizontal: false, vertical: true)
									.font(.body)
									.foregroundColor(Color(.black))
									.multilineTextAlignment(.leading)
									.lineLimit(5)
                                    .fixedSize(horizontal: false, vertical: true)
								Spacer()
								
								mfEntry.journalImage.map { imagedata in
									
									Image(uiImage: UIImage(data: imagedata)!).resizable()
										.renderingMode(.original)
										.aspectRatio(UIImage(data: imagedata)!.size, contentMode: .fill)
										.frame(width: 88, height: 88, alignment: .center)
										.cornerRadius(12)
								}
							}
						}
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.all)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .foregroundColor(Color(hex: mfEntry.moodColorHexCode ?? "EEE"))
                            .offset(x: -1, y: -2)
                            .shadow(color: Color.black.opacity(0.10), radius: 0, x: 1, y: 2)
                    )
					.background(
						RoundedRectangle(cornerRadius: 24)
							.foregroundColor(Color(hex: mfEntry.moodColorHexCode ?? "EEE"))
					)

                }
            }

    }
}

struct JournalRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let sampleMoodJournalEntry = MoodJournalEntry(context: context)
        sampleMoodJournalEntry.journalText = "This is my loooonng journal entry. You can clearly see I'm pissed at this!Why the hell is this not working!!!"
        sampleMoodJournalEntry.moodTitle = "Frustrated"
        sampleMoodJournalEntry.moodEmoji = "😡"
        sampleMoodJournalEntry.moodColorHexCode = ColorManager.pastelRed.uiColor() .hexString
        sampleMoodJournalEntry.journalDate = Date()
        sampleMoodJournalEntry.journalImage = UIImage(named: "testFlower")!.jpegData(compressionQuality: 0.80)
        return JournalRowView(mindFloEntries: [sampleMoodJournalEntry, sampleMoodJournalEntry], isNavigationBarHidden: .constant(false))
    }
}
