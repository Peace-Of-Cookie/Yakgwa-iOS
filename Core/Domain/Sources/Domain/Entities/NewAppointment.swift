//
//  NewAppointment.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

import Foundation

/// 생성중인 약속 엔터티
public struct NewAppointment: Equatable {
    /// 제목
    var title: String?
    /// 설명
    var description: String?
    /// 테마 ID
    var themeId: Int?
    /// (투표) 시작일
    var startDate: Date?
    /// (투표) 종료일
    var endDate: Date?
    /// 직접 입력 일자
    var date: Date?
    
    public init(title: String? = nil, description: String? = nil, date: Date? = nil) {
        self.title = title
        self.description = description
        self.date = date
    }
}

public extension NewAppointment {
    mutating func setThemeId(_ themeId: Int) {
        self.themeId = themeId
    }
    
    mutating func setVoteDate(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
}
