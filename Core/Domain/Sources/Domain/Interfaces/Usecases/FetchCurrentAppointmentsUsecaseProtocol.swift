//
//  FetchCurrentAppointmentsUsecaseProtocol.swift
//
//
//  Created by Ekko on 8/15/24.
//

import RxSwift

public protocol FetchCurrentAppointmentsUsecaseProtocol {
    func execute() -> Single<[AppointmentDetail]>
}
