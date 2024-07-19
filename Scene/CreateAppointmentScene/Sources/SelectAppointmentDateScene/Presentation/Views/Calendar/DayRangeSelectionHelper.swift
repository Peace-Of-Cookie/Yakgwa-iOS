//
//  DayRangeSelectionHelper.swift
//
//
//  Created by Ekko on 7/19/24.
//

import HorizonCalendar

public enum DayRangeSelectionHelper {
    public static func updateDayRange(afterTapSelectionOf day: Day, existingDayRange: inout DayRange?) {
        if let tempExistingDayRange = existingDayRange,
           tempExistingDayRange.lowerBound == tempExistingDayRange.upperBound,
           day > tempExistingDayRange.lowerBound {
            existingDayRange = tempExistingDayRange.lowerBound...day
        } else {
            existingDayRange = day...day
        }
    }
}
