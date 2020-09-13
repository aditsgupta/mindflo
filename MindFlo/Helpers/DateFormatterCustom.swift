//
//  DateFormatterCustom.swift
//  MindFlo
//
//  Created by Adit Gupta on 30/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
extension Formatter {
    static let dayMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    static let hour24: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
    
    static let weekDayShort: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    
    static let timeShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
}
extension Date {
    var dayMedium: String    { return Formatter.dayMedium.string(from: self)}
    var monthMedium: String  { return Formatter.monthMedium.string(from: self) }
    var hour12:  String      { return Formatter.hour12.string(from: self) }
    var hour24: String       { return Formatter.hour24.string(from: self)}
    var minute0x: String     { return Formatter.minute0x.string(from: self) }
    var amPM: String         { return Formatter.amPM.string(from: self) }
    var weekDayShort: String { return Formatter.weekDayShort.string(from: self)}
    var timeShort: String    { return Formatter.timeShort.string(from: self)}
}

