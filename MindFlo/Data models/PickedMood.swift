//
//  PickedMood.swift
//  MindFlo
//
//  Created by Adit Gupta on 10/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
import SwiftUI

class PickedMood: ObservableObject {
    
    @Published var pmEmoji = "🌖"
    @Published var pmColor = ColorManager.bgGrey
    var pmTitle = ""
    var pmJournalText = "" {
        didSet{
            withAnimation(.easeIn(duration: 1.0)){
                pmJournalTextCount = pmJournalText.count
            }
        }
    }
    @Published var pmJournalTextCount = 0
    var pmJournalImage = UIImage()
    var pmJournalDate = Date()
    var pmType = 0 
    
    @Published var writeJournalWithPickedMood = false
    @Published var recheckInHours: Int = 0
    
    func resetPickedMood() {
        pmTitle = ""
        pmEmoji = "🌖"
        pmColor = ColorManager.bgGrey
        pmJournalImage = UIImage()
        pmJournalText = ""
        recheckInHours = 0
    }
}

