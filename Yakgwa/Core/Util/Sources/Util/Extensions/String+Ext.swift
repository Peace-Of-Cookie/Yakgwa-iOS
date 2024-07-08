//
//  String+Ext.swift
//  
//
//  Created by Kim Dongjoo on 7/8/24.
//

import Foundation

public extension String {
    /// String을 Date 형식으로 반환
    func stringToDate(format: DateFormatType) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.date(from: self) ?? Date()
    }
}
