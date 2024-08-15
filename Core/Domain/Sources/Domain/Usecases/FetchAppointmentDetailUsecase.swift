//
//  FetchAppointmentDetailUsecase.swift
//
//
//  Created by Ekko on 8/15/24.
//

import RxSwift

public final class FetchAppointmentDetailUsecase: FetchAppointmentDetailUsecaseProtocol {
    private let repository: FetchAppointmentDetailRepositoryProtocol
    
    public init(repository: FetchAppointmentDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(with entity: MeetID) -> Single<AppointmentDetail> {
        return repository.fetchAppointmentDetail(with: entity)
    }
}
