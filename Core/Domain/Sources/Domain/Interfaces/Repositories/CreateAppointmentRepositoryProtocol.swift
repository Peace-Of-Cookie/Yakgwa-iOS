//
//  CreateAppointmentRepositoryProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/13/24.
//

import Network
import RxSwift

public protocol CreateAppointmentRepositoryProtocol {
    func createAppointment(with entity: NewAppointment) -> Single<MeetID>
}
