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
    /// 직접 입력 시간
    var time: Date?
    /// 후보지
    var candidateLocations: [Location]? = []
    /// 약속 장소
    var location: Location?
    
    public init(title: String? = nil, description: String? = nil, date: Date? = nil) {
        self.title = title
        self.description = description
        self.date = date
    }
}

// MARK: - Setter
public extension NewAppointment {
    mutating func setThemeId(_ themeId: Int) {
        self.themeId = themeId
    }
    
    mutating func setVoteDate(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    mutating func setDateToDirectInput() {
        self.startDate = nil
        self.endDate = nil
    }
    
    mutating func setDateToVote() {
        self.date = nil
        self.time = nil
    }
    
    mutating func setDate(_ date: Date) {
        self.date = date
    }
    
    mutating func setTime(_ time: Date) {
        self.time = time
    }
    
    mutating func setCandicdateLocations(_ locations: [Location]) {
        self.candidateLocations = locations
    }
    
    mutating func setLocation(_ location: Location) {
        self.location = location
    }
    
    mutating func setLocationToVote() {
        self.location = nil
    }
    
    mutating func setLocationToDirectInput() {
        self.candidateLocations = []
    }
}

// MARK: - Getter
public extension NewAppointment {
    func getTitle() -> String? {
        return title
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func getThemeId() -> Int? {
        return themeId
    }
    
    func getStartDate() -> Date? {
        return startDate
    }
    
    func getEndDate() -> Date? {
        return endDate
    }
    
    func getDate() -> Date? {
        return date
    }
    
    func getTime() -> Date? {
        return time
    }
    
    func getCandidateLocations() -> [Location]? {
        return candidateLocations
    }
    
    func getLocation() -> Location? {
        return location
    }
}
