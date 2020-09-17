//
//  WeekDates.swift
//  MindFlo
//
//  Created by Adit Gupta on 07/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation

//Date extension to return a range od Date
extension Date {
  func allDates(till endDate: Date) -> [Date] {
    var date = self
    var array: [Date] = []
    while date <= endDate {
      array.append(date)
      date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }
    return array
  }
}
