//
//  JoinAppointmentRepository.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

import Network
import Domain

import RxSwift

public class JoinAppointmentRepository: JoinAppointmentRepositoryProtocol {
    private let remoteDataSource: RemoteJoinAppointmentDataSourceProtocol
    
    public init(remoteDataSource: RemoteJoinAppointmentDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func joinAppointment(with entity: MeetID) -> Single<Int> {
        return remoteDataSource
            .joinAppointment(requestDTO:
                                JoinAppointmentRequestDTO(from: entity))
            .map { $0.result.participantId }
    }
}
