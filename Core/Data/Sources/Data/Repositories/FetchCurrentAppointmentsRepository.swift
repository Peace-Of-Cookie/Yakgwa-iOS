//
//  FetchCurrentAppointmentsRepository.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Network
import Domain
import RxSwift

public final class FetchCurrentAppointmentsRepository: FetchCurrentAppointmentsRepositoryProtocol {
    private let remoteDataSource: RemoteFetchCurrentAppointmentDataSourceProtocol
    
    public init(remoteDataSource: RemoteFetchCurrentAppointmentDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchCurrentAppointments() -> Single<[AppointmentDetail]> {
        return remoteDataSource.fetchCurrentAppointments()
            .map { $0.toDomain() }
    }
}
