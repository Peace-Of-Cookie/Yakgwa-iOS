//
//  FetchAppointmentRepositoryProtocol.swift
//
//
//  Created by Ekko on 7/24/24.
//

import Network
import RxSwift

protocol FetchAppointmentRepositoryProtocol {
    func fetchAppointment() -> Single<[Appointment]>
}
