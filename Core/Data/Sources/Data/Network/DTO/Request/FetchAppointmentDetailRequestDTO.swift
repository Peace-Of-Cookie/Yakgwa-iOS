//
//  FetchAppointmentDetailRequestDTO.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Foundation
import Domain

public struct FetchAppointmentDetailRequestDTO: Encodable {
    public let meetId: Int
}

public extension FetchAppointmentDetailRequestDTO {
    init(from entity: MeetID) {
        self.meetId = entity.getMeetId()
    }
}
