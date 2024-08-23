//
//  AppointmentDetailViewModel.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
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
        self.participants = entity.getParticipants() ?? []
    }
}
