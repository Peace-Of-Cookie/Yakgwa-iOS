//
//  FetchAppointmentUsecase.swift
//
//
//  Created by Ekko on 7/24/24.
//

import Network
import RxSwift

public protocol FetchAppointmentUsecase {
    func execute() -> Single<[Appointment]>
}

public final class DefaultFetchAppointmentUsecase: FetchAppointmentUsecase {
    private let repository: FetchAppointmentRepositoryProtocol

    public init(repository: FetchAppointmentRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() -> Single<[Appointment]> {
        return repository.fetchAppointment()
    }
}
