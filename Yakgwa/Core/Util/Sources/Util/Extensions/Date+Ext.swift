//
//  Date+Ext.swift
//
//
//  Created by Kim Dongjoo on 7/8/24.
//

import Foundation

public extension Date {
    /// Date를 String으로 반환
    func dateToString(format: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
