//
//  AppointmentViewModel.swift
//  HomeScene
//
//  Created by Kim Dongjoo on 9/25/24.
//

import Foundation
import Domain

public struct AppointmentDetailViewModel: Equatable {
    /// 모임 상태
    let state: String?
    /// 모임 테마
    let theme: String
    /// 타이틀
    let title: String
    /// 설명
    var description: String = ""
    /// 남은 약속 날짜
    let remainVoteTime: String? // D - N
    /// 날짜
    var date: String = ""
    /// 시간
    var time: String = ""
    /// 약속 장소
    var location: String = ""
    
    public init(state: String, theme: String, title: String, description: String, remainVoteTime: String?, date: String, location: String, time: String) {
        self.state = state
        self.theme = theme
        self.title = title
        self.description = description
        self.remainVoteTime = remainVoteTime
        self.date = date
        self.location = location
        self.time = time
    }
    
    public init(with entity: AppointmentDetail) {
        self.state = entity.getStatus() ?? ""
        self.theme = entity.getThemeName() ?? ""
        self.title = entity.getTitle() ?? ""
        self.description = entity.getDescription() ?? ""
        self.location = entity.getLocation() ?? ""
        
        if let dateTime = entity.getDate() {
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            self.date = dateFormatter.string(from: dateTime)
            
            let timeFormatter = DateFormatter()
            timeFormatter.locale = Locale(identifier: "ko_KR")
            timeFormatter.amSymbol = "오전"
            timeFormatter.pmSymbol = "오후"
            timeFormatter.dateFormat = "a h시"
            self.time = timeFormatter.string(from: dateTime)
            
            let currentDate = Date()
            let calendar = Calendar.current
            let daysRemaining = calendar.dateComponents([.day], from: calendar.startOfDay(for: currentDate), to: calendar.startOfDay(for: dateTime)).day ?? 0
            
            if daysRemaining > 0 {
                self.remainVoteTime = "D - \(daysRemaining)"
            } else if daysRemaining == 0 {
                self.remainVoteTime = "D-Day"
            } else {
                self.remainVoteTime = nil
            }
            
        } else {
            self.date = ""
            self.time = ""
            self.remainVoteTime = nil
        }
    }
}
