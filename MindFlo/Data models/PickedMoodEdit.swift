//
//  PickedMoodEdit.swift
//  MindFlo
//
//  Created by Adit Gupta on 10/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
import SwiftUI

class PickedMoodEdit: ObservableObject {
    
    @Published var moodEmoji = ""
    @Published var moodColorHexCode = "eee"
    var moodTitle = ""
    var journalText = "" {
        didSet{
            withAnimation(.easeIn(duration: 1.0)){
                journalTextCount = journalText.count
            }
        }
    }
    var journalImage = UIImage()
    var journalDate = Date()
    @Published var journalTextCount = 0

}
