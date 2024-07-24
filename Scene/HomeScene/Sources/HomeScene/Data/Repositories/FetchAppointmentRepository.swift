//
//  FetchAppointmentRepository.swift
//
//
//  Created by Ekko on 7/24/24.
//

import Network
import RxSwift

public final class FetchAppointmentRepository: FetchAppointmentRepositoryProtocol {
    private let remoteDataSource: RemoteFetchAppointmentDataSourceProtocol
    
    init(remoteDataSource: RemoteFetchAppointmentDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchAppointment() -> Single<[Appointment]> {
        return remoteDataSource
            .fetchAppointments()
            .map {
                $0.toDomain()
            }
    }
}
