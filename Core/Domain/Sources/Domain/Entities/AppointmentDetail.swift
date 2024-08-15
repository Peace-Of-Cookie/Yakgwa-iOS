//
//  AppointmentDetail.swift
//
//
//  Created by Ekko on 8/15/24.
//
import Foundation

public struct AppointmentDetail: Equatable {
    /// 약속 이름
    let title: String?
    /// 약속 설명
    let description: String?
    /// 테마명
    let themeName: String?
    /// 참가자 정보
    let participants: [Participant]?
    /// 상태
    let status: String?
    /// 약속 시간
    let dateTime: Date?
    /// 약속 장소
    let location: String?
    /// 약속 id
    let meetId: Int?
    
    public init(title: String?, description: String?, themeName: String?, participants: [Participant]?, status: String?, dateTime: Date?, location: String?, meetId: Int?) {
        self.title = title
        self.description = description
        self.themeName = themeName
        self.participants = participants
        self.status = status
        self.dateTime = dateTime
        self.location = location
        self.meetId = meetId
    }
}

public extension AppointmentDetail {
    func getTitle() -> String? {
        return title
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func getThemeName() -> String? {
        return themeName
    }
    
    func getParticipants() -> [Participant]? {
        return participants
    }
}
