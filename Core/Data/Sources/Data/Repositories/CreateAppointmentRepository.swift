//
//  CreateAppointmentRepository.swift
//
//
//  Created by Kim Dongjoo on 8/13/24.
//

import Network
import RxSwift
import Domain

public final class CreateAppointmentRepository: CreateAppointmentRepositoryProtocol {
    private let remoteDataSource: RemoteCreateAppointmentDataSourceProtocol
    
    public init(remoteDataSource: RemoteCreateAppointmentDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func createAppointment(with entity: NewAppointment) -> Single<MeetID> {
        return remoteDataSource
            .createAppointment(with: CreateAppointmentRequestDTO(from: entity))
            .map { $0.toDomain() }
    }
}
