//
//  JoinAppointmentRequestDTO.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

import Foundation
import Domain

public struct JoinAppointmentRequestDTO: Encodable {
    public let meetId: Int
}

public extension JoinAppointmentRequestDTO {
    init(from entity: MeetID) {
        self.meetId = entity.getMeetId()
    }
}
