//
//  JoinAppointmentUsecase.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

import RxSwift

public final class JoinAppointmentUsecase: JoinAppointmentUsecaseProtocol {
    private let repository: JoinAppointmentRepositoryProtocol
    
    public init(repository: JoinAppointmentRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(with entity: MeetID) -> Single<Int> {
        return repository.joinAppointment(with: entity)
    }
}
