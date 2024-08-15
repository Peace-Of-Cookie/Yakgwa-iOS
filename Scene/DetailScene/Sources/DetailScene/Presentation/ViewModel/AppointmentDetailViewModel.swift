//
//  AppointmentDetailViewModel.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Foundation
import Domain

public struct AppointmentDetailViewModel: Equatable {
    let theme: String
    let title: String
    var description: String = ""
    let remainVoteTime: String = ""
    var participants: [Participant] = []
}

extension AppointmentDetailViewModel {
    init(with entity: AppointmentDetail) {
        self.theme = entity.getThemeName() ?? ""
        self.title = entity.getTitle() ?? ""
        self.description = entity.getDescription() ?? ""
        
        // 필터링하여 participants에 추가
        self.participants = entity.getParticipants()?.filter { participant in
            participant.getRole() != "LEADER"
        } ?? []
        
    }
}
