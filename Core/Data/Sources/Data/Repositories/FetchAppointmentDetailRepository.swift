//
//  FetchAppointmentDetailRepository.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Network
import RxSwift
import Domain

public final class FetchAppointmentDetailRepository: FetchAppointmentDetailRepositoryProtocol {
    private let remoteDataSource: RemoteFetchAppointmentDetailDataSourceProtocol
    
    public init(remoteDataSource: RemoteFetchAppointmentDetailDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchAppointmentDetail(with entity: MeetID) -> Single<AppointmentDetail> {
        return remoteDataSource
            .fetchAppointmentDetail(requestDTO: FetchAppointmentDetailRequestDTO(from: entity))
            .map { $0.toDomain() }
    }
}
