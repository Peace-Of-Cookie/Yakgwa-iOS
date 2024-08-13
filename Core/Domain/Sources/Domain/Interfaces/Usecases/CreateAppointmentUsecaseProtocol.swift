//
//  CreateAppointmentUsecaseProtocol.swift
//
//
//  Created by Ekko on 8/13/24.
//

import RxSwift

public protocol CreateAppointmentUsecaseProtocol {
    func execute(appointment: NewAppointment) -> Single<MeetID>
}
