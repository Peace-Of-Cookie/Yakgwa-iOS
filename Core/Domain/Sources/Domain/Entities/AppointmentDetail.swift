//
//  AppointmentDetail.swift
//
//
//  Created by Ekko on 8/15/24.
//

public struct AppointmentDetail: Equatable {
    /// 약속 이름
    let title: String?
    /// 약속 설명
    let description: String?
    /// 테마명
    let themeName: String?
    /// 참가자 정보
    let participants: [Participant]?
    
    public init(title: String?, description: String?, themeName: String?, participants: [Participant]?) {
        self.title = title
        self.description = description
        self.themeName = themeName
        self.participants = participants
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
