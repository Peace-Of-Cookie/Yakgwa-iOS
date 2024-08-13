//
//  CreateAppointmentUsecase.swift
//
//
//  Created by Ekko on 8/13/24.
//

import RxSwift

public final class CreateAppointmentUsecase: CreateAppointmentUsecaseProtocol {
    private let repository: CreateAppointmentRepositoryProtocol
    
    public init(repository: CreateAppointmentRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(appointment: NewAppointment) -> Single<MeetID> {
        return repository.createAppointment(with: appointment)
    }
}
