//
//  FetchCurrentAppointmentUsecase.swift
//
//
//  Created by Ekko on 8/15/24.
//

import RxSwift

public final class FetchCurrentAppointmentUsecase: FetchCurrentAppointmentsUsecaseProtocol {
    private let repository: FetchCurrentAppointmentsRepositoryProtocol
    
    public init(repository: FetchCurrentAppointmentsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> Single<[AppointmentDetail]> {
        return repository.fetchCurrentAppointments()
    }
}
