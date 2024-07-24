//
//  FetchAppointmentUsecase.swift
//
//
//  Created by Ekko on 7/24/24.
//

import Network
import RxSwift

protocol FetchAppointmentUsecase {
    func execute() -> Single<[Appointment]>
}

public final class DefaultFetchAppointmentUsecase: FetchAppointmentUsecase {
    private let repository: FetchAppointmentRepositoryProtocol

    init(repository: FetchAppointmentRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> Single<[Appointment]> {
        repository.fetchAppointment()
    }
}
