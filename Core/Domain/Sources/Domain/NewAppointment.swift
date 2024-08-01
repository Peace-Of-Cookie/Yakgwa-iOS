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
    /// 시작일
    var date: Date?
    
    public init(title: String? = nil, description: String? = nil, date: Date? = nil) {
        self.title = title
        self.description = description
        self.date = date
    }
}
