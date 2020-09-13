//
//  Mood.swift
//  MindFlo
//
//  Created by Adit Gupta on 09/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
import SwiftUI

struct Mood: Identifiable {
    var id = UUID()
    var moodType: Int
    var moodEmoji: String
    var moodTitles: [String]
    var moodColor: Color {
        //For defaulting colors
        switch moodType {
        case 1: //Happy
            return ColorManager.pastelYellow
        case 2: //Sad
            return ColorManager.pastelBlue
        case 3: //Anger
            return ColorManager.pastelRed
        case 4: //Fear
            return ColorManager.pastelPurple
        case 5: //Disgust
            return ColorManager.pastelGreen
        default:
            return ColorManager.bgGrey
        }
    }
}
