//
//  JoinAppointmentRepositoryProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

import Network

import RxSwift

public protocol JoinAppointmentRepositoryProtocol {
    // Return participantId
    func joinAppointment(with entity: MeetID) -> Single<Int>
}
