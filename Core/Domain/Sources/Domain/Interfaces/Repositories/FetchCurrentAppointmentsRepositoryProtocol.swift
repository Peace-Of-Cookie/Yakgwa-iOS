//
//  FetchCurrentAppointmentsRepositoryProtocol.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Network

import RxSwift

public protocol FetchCurrentAppointmentsRepositoryProtocol {
    func fetchCurrentAppointments() -> Single<[AppointmentDetail]>
}
